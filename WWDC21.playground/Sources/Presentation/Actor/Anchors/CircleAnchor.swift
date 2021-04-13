// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

class CircleAnchor: SKNode {
    // MARK: - ShapeNode
    private let shapeNode: SKShapeNode

    // MARK: - Initialization
    init(position: CGPoint, radius: CGFloat = 20) {
        self.shapeNode = .init(circleOfRadius: radius)
        super.init()
        self.position = position
        configureNode()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(shapeNode)
        shapeNode.blendMode = .replace
        shapeNode.fillColor = .smokyBlack
        shapeNode.lineWidth = 0
    }
}
