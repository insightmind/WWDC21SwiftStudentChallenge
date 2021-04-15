// Copyright © 2020 Niklas Buelow. All rights reserved.

import SwiftUI
import SpriteKit
import PlaygroundSupport

public struct QuantumControlGame: View {
    // MARK: - Properties
    private static let viewSize: CGSize = CGSize(width: 750, height: 750)
    private var gameState: GameState = .simulation
    private var theme: GameTheme = .basic

    // MARK: - Public Properties
    @ObservedObject
    private var scene: SKScene = SKScene()

    /// Use this view to present the game.
    public var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: QuantumControlGame.viewSize.width, height: QuantumControlGame.viewSize.width)
                .ignoresSafeArea()

            BlurView(style: .systemThinMaterialDark)
                .ignoresSafeArea()
        }

    }

    // MARK: - Initialization
    /// Starts the game. You can then use the view to show it on screen.
    /// - Parameter isDebug: If true the SpriteKit debug menu is shown
    public init(isDebug: Bool = false) {
        scene = gameState.loadScene(size: QuantumControlGame.viewSize)
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
    }
}
