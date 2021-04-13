import CoreGraphics

extension CGPoint {
    init(length: CGFloat, direction: CGPoint) {
        self = direction
            .normalized()
            .scalarMultiply(length)
    }

    public func normalized() -> CGPoint {
        return .init(x: x / length(), y: y / length())
    }

    public func scalarMultiply(_ value: CGFloat) -> CGPoint {
        return .init(x: x * value, y: y * value)
    }

    public func length() -> CGFloat {
        return hypot(x, y)
    }

    public func difference(to otherPoint: CGPoint) -> CGPoint {
        return .init(x: otherPoint.x - x, y: otherPoint.y - y)
    }

    public func transform(by rect: CGRect) -> CGPoint {
        return .init(x: x * rect.width + rect.minX, y: y * rect.height + rect.minY)
    }

    public func add(_ otherPoint: CGPoint) -> CGPoint {
        return .init(x: x + otherPoint.x, y: y + otherPoint.y)
    }

    public func dot(_ otherPoint: CGPoint) -> CGFloat {
        return x * otherPoint.x + y * otherPoint.y
    }

    public func orientedAngle(to otherPoint: CGPoint) -> CGFloat {
        let first = normalized()
        let second = otherPoint.normalized()
        return atan2(first.x * second.y - first.y * second.x, first.x * second.x - first.y * second.y)
    }
}
