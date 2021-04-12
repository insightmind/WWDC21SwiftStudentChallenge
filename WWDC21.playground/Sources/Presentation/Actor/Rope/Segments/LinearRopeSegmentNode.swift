// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class LinearRopeSegmentNode: RopeSegmentNode {
    // MARK: - Drawing
    override func drawPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: startPoint.vector(to: endPoint))
        return path.cgPath
    }
}
