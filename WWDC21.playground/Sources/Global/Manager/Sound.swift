import Foundation

enum Sound {
    case laser
    case backgroundMusic

    var fileName: String {
        switch self {
        case .laser:
            return "Audio/Laser"

        case .backgroundMusic:
            return "Audio/BackgroundMusic"
        }
    }
}
