import Foundation

// Copyright © 2020 Niklas Buelow. All rights reserved.

import SpriteKit

/**
 * This enum specifies the individual scenes in the game.
 * You can use them to automatically load a scene and supply it with the necessary paramters
 * such as their expected models
 */
enum GameState {
    case menu
    case editor
    case simulation
    case levelBuilder

    /// Loads the associated scene and assigns the necessary parameters
    func loadScene(size: CGSize) -> FlowableScene {
        switch self {
        case .menu:
            return SimulationScene(size: size)

        case .editor:
            return SimulationScene(size: size)

        case .simulation:
            return SimulationScene(size: size)

        case .levelBuilder:
            return SimulationScene(size: size)
        }
    }
}
