import Foundation

// Copyright © 2020 Niklas Buelow. All rights reserved.

import SpriteKit

/**
 * This enum specifies the individual scenes in the game.
 * You can use them to automatically load a scene and supply it with the necessary paramters
 * such as their expected models
 */
enum GameState {
    case game

    /// Loads the associated scene and assigns the necessary parameters
    func loadScene(size: CGSize) -> FlowableScene {
        switch self {
        case .game:
            return GameScene(size: size)
        }
    }
}
