// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class LinearRopeSegmentNode: RopeSegmentNode {
    // MARK: - Drawing
    override func drawPath(path: CGMutablePath) -> CGMutablePath {
        path.addLine(to: endPoint)
        return path
    }
}
