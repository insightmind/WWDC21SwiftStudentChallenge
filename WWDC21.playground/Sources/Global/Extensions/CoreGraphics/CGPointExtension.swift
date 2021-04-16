import CoreGraphics

extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return .init(x: left.x + right.x, y: left.y + right.y)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return .init(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return .init(x: left.x * right, y: left.y * right)
    }

    static func linearInterpolate(first: CGPoint, second: CGPoint, parameter: CGFloat) -> CGPoint {
        return first + (second - first) * parameter
    }
}
