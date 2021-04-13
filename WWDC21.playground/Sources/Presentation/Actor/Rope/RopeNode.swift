// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

public class RopeNode: SKSpriteNode {
    // MARK: - Properties
    private var segments: [RopeSegmentNode]
    private var startPoint: CGPoint
    var keyColor: UIColor = .charcoal {
        didSet { shapeNode.strokeColor = keyColor }
    }

    // MARK: - Subnodes
    private let shapeNode = SKShapeNode()

    // MARK: - Initialization
    public init(startAnchor: CGPoint, size: CGSize) {
        self.startPoint = startAnchor

        let initialSegment = BendAnchorSegmentNode(bendAnchor: startAnchor.add(.init(x: 100, y: 0)), curveRadius: 50)
        initialSegment.endPoint = startAnchor
        self.segments = [initialSegment]

        super.init(texture: nil, color: .clear, size: size)
        configureNode()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Node Configuration
    private func configureNode() {
        addChild(shapeNode)
        shapeNode.strokeColor = keyColor
        shapeNode.lineWidth = 50
        shapeNode.lineCap = .round
        redrawAll()
    }

    // MARK: - Methods
    private func redrawAll() {
        var path = CGMutablePath()
        path.move(to: startPoint)

        segments.forEach { segment in
            path = segment.drawPath(path: path)
        }

        shapeNode.path = path
    }

    func updateEndPoint(_ endPoint: CGPoint, anchors: [CircleAnchor]) {
        let previousPath = shapeNode.path

        guard let lastSegment = segments.last else { return }

        lastSegment.endPoint = endPoint
        redrawAll()

        if lastSegment.evaluateCollisionAnchors(anchors) {
            shapeNode.path = previousPath
        }
    }
}


