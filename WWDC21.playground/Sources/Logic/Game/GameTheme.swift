import Foundation

enum GameTheme {
    case basic

    var palette: ColorPalette {
        switch self {
        case .basic:
            return .init(colors: [.charcoal, .persianGreen, .crayola, .sandyBrown, .burntSienna], backgroundColor: .almondWhite)
        }
    }
}
