import Foundation

enum Sound {
    case laser

    var fileName: String {
        switch self {
        case .laser:
            return "Audio/Laser"
        }
    }
}
