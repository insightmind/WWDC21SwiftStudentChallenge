import CoreGraphics

enum GridDirection {
    case left
    case leftUp
    case leftDown
    case up
    case right
    case rightUp
    case rightDown
    case down

    var vector: CGVector {
        switch self {
        case .left:
            return .init(dx: -1, dy: 0)

        case .leftUp:
            return .init(dx: -1, dy: 1).normalized
            
        case .leftDown:
            return .init(dx: -1, dy: -1).normalized

        case .up:
            return .init(dx: 0, dy: 1)

        case .right:
            return .init(dx: 1, dy: 0)

        case .rightUp:
            return .init(dx: 1, dy: 1).normalized

        case .rightDown:
            return .init(dx: 1, dy: -1).normalized

        case .down:
            return .init(dx: 0, dy: -1)
        }
    }

    var rotationInRadians: CGFloat {
        switch self {
        case .left:
            return Self.leftDown.rotationInRadians + .pi / 4

        case .leftUp:
            return Self.left.rotationInRadians + .pi / 4

        case .leftDown:
            return Self.down.rotationInRadians + .pi / 4

        case .up:
            return Self.leftUp.rotationInRadians + .pi / 4

        case .right:
            return 0

        case .rightUp:
            return Self.up.rotationInRadians + .pi / 4

        case .rightDown:
            return Self.right.rotationInRadians + .pi / 4

        case .down:
            return Self.rightDown.rotationInRadians + .pi / 4
        }
    }

    var moveBitMask: UInt32 {
        switch self {
        case .left:
            return 0b0000_0001

        case .leftUp:
            return 0b0000_0001

        case .leftDown:
            return 0b0000_0100

        case .up:
            return 0b0000_1000

        case .right:
            return 0b0001_0000

        case .rightUp:
            return 0b0010_0000

        case .rightDown:
            return 0b0100_0000

        case .down:
            return 0b1000_0000
        }
    }

    var receiveBitMask: UInt32 {
        switch self {
        case .left:
            return Self.right.moveBitMask

        case .leftUp:
            return Self.rightDown.moveBitMask

        case .leftDown:
            return Self.rightUp.moveBitMask

        case .up:
            return Self.down.moveBitMask

        case .right:
            return Self.left.moveBitMask

        case .rightUp:
            return Self.leftDown.moveBitMask

        case .rightDown:
            return Self.leftUp.moveBitMask

        case .down:
            return Self.up.moveBitMask
        }
    }
}
