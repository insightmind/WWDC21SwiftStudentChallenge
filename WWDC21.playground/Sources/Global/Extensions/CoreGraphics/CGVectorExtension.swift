import CoreGraphics

extension CGVector {
    var normalized: CGVector { .init(dx: dx / length, dy: dy / length) }
    var length: CGFloat { hypot(dx, dy) }
}
