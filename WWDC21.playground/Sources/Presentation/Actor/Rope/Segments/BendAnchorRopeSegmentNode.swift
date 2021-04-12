// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

class BendAnchorSegmentNode: RopeSegmentNode {
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

        let firstDirection = startPoint.vector(to: bendAnchor)
        let firstCurveAnchor = CGPoint(length: firstDirection.length() - curveRadius / 2, direction: firstDirection)
        let secondDirection = bendAnchor.vector(to: endPoint)
        let secondCurveAnchor = firstDirection.add(CGPoint(length: curveRadius / 2, direction: secondDirection))

        path.addLine(to: firstCurveAnchor)
        path.addQuadCurve(to: secondCurveAnchor, controlPoint: startPoint.vector(to: bendAnchor))
        path.addLine(to: startPoint.vector(to: endPoint))
        return path.cgPath
    }
}
