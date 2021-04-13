// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class BendAnchorSegmentNode: RopeSegmentNode {
    private let bendAnchor: CGPoint
    private let curveRadius: CGFloat

    // MARK: - Initialization
    init(bendAnchor: CGPoint, curveRadius: CGFloat) {
        self.bendAnchor = bendAnchor
        self.curveRadius = curveRadius
        super.init()
    }

    // MARK: - Drawing
    override func drawPath(path: CGMutablePath) -> CGMutablePath {
        let firstDirection = path.currentPoint.difference(to: bendAnchor)
        let firstCurveAnchor = CGPoint(length: firstDirection.length() - curveRadius / 2, direction: firstDirection)
        let secondDirection = bendAnchor.difference(to: endPoint)
        let secondCurveAnchor = firstDirection.add(CGPoint(length: curveRadius / 2, direction: secondDirection))

        path.addLine(to: firstCurveAnchor)
        path.addQuadCurve(to: secondCurveAnchor, control: bendAnchor)
        path.addLine(to: endPoint)

        return path
    }
}
