// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

class RopeSegmentNode: SKNode {
    // MARK: - Properties
    let startPoint: CGPoint
    var endPoint: CGPoint {
        didSet { redraw() }
    }

    var isStatic: Bool = false
    var keyColor: UIColor = .charcoal {
        didSet { shapeNode.strokeColor = keyColor }
    }

    // MARK: - Subnodes
    private let shapeNode = SKShapeNode()

    // MARK: - Initialization
    init(startPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = startPoint

        super.init()

        configureNode()
        redraw()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure Node
    private func configureNode() {
        // TODO: Add customizable styling
        shapeNode.strokeColor = keyColor
        shapeNode.lineWidth = 50
        shapeNode.lineCap = .square

        addChild(shapeNode)
    }

    // MARK: - Drawing
    func drawPath() -> CGPath {
        // Override this in subclass
        fatalError("Override this in subclass")
    }

    private func redraw() {
        guard !isStatic else { return }
        shapeNode.path = drawPath()
    }
}
