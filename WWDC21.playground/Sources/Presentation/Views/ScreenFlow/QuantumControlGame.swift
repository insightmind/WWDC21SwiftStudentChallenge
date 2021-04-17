// Copyright © 2020 Niklas Buelow. All rights reserved.

import SwiftUI
import SpriteKit
import PlaygroundSupport

public struct QuantumControlGame: View {
    // MARK: - Properties
    private let viewSize: CGSize = CGSize(width: 750, height: 750)

    // MARK: - State properties
    @ObservedObject private var gameStore = GameStore()
    @ObservedObject private var scene: SimulationScene

    /// Use this view to present the game.
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)

            GameView(viewSize: viewSize, scene: scene, gameStore: gameStore, gameState: $gameStore.gameState)

            ZStack {
                if gameStore.gameState != .game {
                    BlurView(style: .systemUltraThinMaterialDark)

                    switch gameStore.gameState {
                    case .game:
                        EmptyView()

                    case .menu:
                        MenuView(gameState: $gameStore.gameState)

                    case .pause:
                        PauseView(gameState: $gameStore.gameState)

                    case .levelName:
                        LevelNameView(level: $gameStore.levelName, gameState: $gameStore.gameState)
                    }
                }
            }
            .transition(.opacity)
        }
        .animation(.default)
        .frame(width: viewSize.width, height: viewSize.height)
    }

    // MARK: - Initialization
    /// Starts the game. You can then use the view to show it on screen.
    /// - Parameter isDebug: If true the SpriteKit debug menu is shown
    public init(isDebug: Bool = false) {
        scene = SimulationScene(size: viewSize)
        scene.onCompletion = didCompleteLevel
        scene.level = .level(index: 1)
    }

    // MARK: - Methods
    private func didCompleteLevel(_ level: AvailableLevels) {
        scene.level = level.next
        gameStore.levelName = scene.level.name
    }
}
