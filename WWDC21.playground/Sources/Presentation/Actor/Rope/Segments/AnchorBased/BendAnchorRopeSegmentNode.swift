// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class BendAnchorSegmentNode: RopeSegmentNode {
    private let bendAnchor: CGPoint
    private let curveRadius: CGFloat

    // MARK: - Initialization
    init(startPoint: CGPoint, bendAnchor: CGPoint, curveRadius: CGFloat) {
        self.bendAnchor = bendAnchor
        self.curveRadius = curveRadius
        super.init(startPoint: startPoint)
    }

    // MARK: - Drawing
    override func drawPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: .zero)

        let firstDirection = startPoint.difference(to: bendAnchor)
        let firstCurveAnchor = CGPoint(length: firstDirection.length() - curveRadius / 2, direction: firstDirection)
        let secondDirection = bendAnchor.difference(to: endPoint)
        let secondCurveAnchor = firstDirection.add(CGPoint(length: curveRadius / 2, direction: secondDirection))

        path.addLine(to: firstCurveAnchor)
        path.addQuadCurve(to: secondCurveAnchor, controlPoint: startPoint.difference(to: bendAnchor))
        path.addLine(to: startPoint.difference(to: endPoint))

        return path.cgPath
    }
}
