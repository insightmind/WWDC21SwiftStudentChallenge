// Copyright © 2021 Niklas Buelow. All rights reserved.

import Foundation

enum GameState {
    case levelName(level: AvailableLevels)
    case pause
    case game
    case menu
    case finish
}
