// Copyright © 2020 Niklas Buelow. All rights reserved.

import Foundation
import SpriteKit
import PlaygroundSupport

public class QuantumControlGame: PlaygroundLiveViewable {
    // MARK: - Public Properties
    public var playgroundLiveViewRepresentation: PlaygroundLiveViewRepresentation {
        return .view(view)
    }

    /// Use this view to present the game.
    private lazy var view: BaseGameView = BaseGameView()

    public init() { /* Nothing special */ }
}
