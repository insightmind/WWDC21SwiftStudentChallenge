// Copyright © 2020 Niklas Buelow. All rights reserved.

import SwiftUI
import SpriteKit
import PlaygroundSupport

public struct QuantumControlGame: View {
    // MARK: - Properties
    private static let viewSize: CGSize = CGSize(width: 750, height: 750)
    private var gameState: GameState = .simulation

    // MARK: - State properties
    @State
    private var isPaused = false
    @State
    private var isSoundEnabled = true

    @ObservedObject
    private var scene: SKScene = SKScene()

    /// Use this view to present the game.
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)

            ZStack {
                SpriteView(scene: scene)
                    .frame(width: QuantumControlGame.viewSize.width, height: QuantumControlGame.viewSize.height)
                    .ignoresSafeArea()

                InGameView(isPaused: $isPaused, isSoundEnabled: $isSoundEnabled)
            }
            .scaleEffect(isPaused ? 0.9 : 1.0)

            ZStack {
                if isPaused {
                    ZStack {
                        BlurView(style: .systemUltraThinMaterialDark)

                        VStack {
                            Image(uiImage: UIImage(named: "Images/Playground/QuantumControl-Logo.png")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)

                            Button {
                                withAnimation(.spring()) {
                                    isPaused.toggle()
                                }
                            } label : {
                                ThemeButtonContentView(iconName: "play.fill")
                            }
                        }
                    }
                }
            }
        }
        .frame(width: QuantumControlGame.viewSize.width, height: QuantumControlGame.viewSize.height)
    }


    // MARK: - Initialization
    /// Starts the game. You can then use the view to show it on screen.
    /// - Parameter isDebug: If true the SpriteKit debug menu is shown
    public init(isDebug: Bool = false) {
        scene = gameState.loadScene(size: QuantumControlGame.viewSize)
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
    }
}
