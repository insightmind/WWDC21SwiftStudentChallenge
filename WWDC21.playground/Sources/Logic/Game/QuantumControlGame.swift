// Copyright © 2020 Niklas Buelow. All rights reserved.

import Foundation
import SpriteKit
import PlaygroundSupport

public class QuantumControlGame: PlaygroundLiveViewable {
    // MARK: - Properties
    private let viewSize: CGSize = CGSize(width: 800, height: 800)
    private var gameState: GameState = .game
    private var theme: GameTheme = .basic

    // MARK: - Public Properties
    public var playgroundLiveViewRepresentation: PlaygroundLiveViewRepresentation {
        return .view(view)
    }

    /// Use this view to present the game.
    public lazy var view: SKView = {
        let frame = CGRect(origin: .zero, size: self.viewSize)
        let view = SKView(frame: frame)
        view.presentScene(scene)
        return view
    }()

    private var scene: SKScene = SKScene()

    // MARK: - Initialization
    /// Starts the game. You can then use the view to show it on screen.
    /// - Parameter isDebug: If true the SpriteKit debug menu is shown
    public init(isDebug: Bool = true) {
        view.showsFPS = isDebug
        view.showsFields = isDebug
        view.showsDrawCount = isDebug
        view.showsNodeCount = isDebug
        view.showsQuadCount = isDebug

        scene = gameState.loadScene(size: viewSize)
        scene.anchorPoint = .init(x: 0.5, y: 0.5)
        view.presentScene(scene)
    }
}
