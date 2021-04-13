import CoreGraphics

enum GridDirection {
    case left
    case up
    case right
    case down

    var vector: CGVector {
        switch self {
        case .left:
            return .init(dx: -1, dy: 0)

        case .up:
            return .init(dx: 0, dy: 1)

        case .right:
            return .init(dx: 1, dy: 0)

        case .down:
            return .init(dx: 0, dy: -1)
        }
    }
}
