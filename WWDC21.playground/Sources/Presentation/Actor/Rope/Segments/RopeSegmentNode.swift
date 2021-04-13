// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

class RopeSegmentNode: SKNode {
    // MARK: - Properties
    var endPoint: CGPoint
    var interactableStartPoint: CGPoint

    // MARK: - Initialization
    override init() {
        self.endPoint = .zero
        self.interactableStartPoint = .zero
        super.init()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Drawing
    func drawPath(path: CGMutablePath) -> CGMutablePath {
        self.interactableStartPoint = path.currentPoint
        return path
    }

    func evaluateCollisionAnchors(_ anchors: [CircleAnchor]) -> Bool {
        let path = CGMutablePath()
        path.move(to: interactableStartPoint)
        let generatedPath = drawPath(path: path)

        for anchor in anchors {
            let accumulatedFrame = anchor.calculateAccumulatedFrame()
            let intersectRect = generatedPath.boundingBoxOfPath.intersection(accumulatedFrame)
            guard intersectRect != .null else { continue }
            return true
        }

        return false
    }
}
