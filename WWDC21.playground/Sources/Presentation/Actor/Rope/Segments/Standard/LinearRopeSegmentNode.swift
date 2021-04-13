// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class LinearRopeSegmentNode: RopeSegmentNode {
    // MARK: - Drawing
    override func drawPath() -> CGPath {
        print("Start: \(startPoint), End: \(endPoint)")

        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path.cgPath
    }
}
