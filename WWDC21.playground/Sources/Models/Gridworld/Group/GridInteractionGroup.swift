import SpriteKit

enum GridInteractionGroup: String, Codable {
    case red
    case blue
    case green
    case yellow
    case pink
    case purple
    case orange

    var baseColor: UIColor {
        switch self {
        case .red:
            return .init(hex: "e71d36")

        case .blue:
            return .init(hex: "4cc9f0")

        case .green:
            return .init(hex: "70e000")

        case .yellow:
            return .init(hex: "ffbe0b")

        case .pink:
            return .init(hex: "ff006e")

        case .purple:
            return .init(hex: "8338ec")

        case .orange:
            return .init(hex: "fb5607")
        }
    }
}
