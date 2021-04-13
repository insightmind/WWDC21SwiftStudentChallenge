import Foundation

enum GameTheme {
    case basic

    var palette: ColorPalette {
        switch self {
        case .basic:
            return .init(colors: [.flickrPink, .neonPurple, .persianBlue, .vividBlue], backgroundColor: .darkPurple)
        }
    }
}
