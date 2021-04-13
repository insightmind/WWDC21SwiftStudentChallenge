// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

public class RopeNode: SKSpriteNode {
    // MARK: - Properties
    private var segments: NonEmptyStack<RopeSegmentNode>
    private var startPoint: CGPoint
    var keyColor: UIColor = .charcoal {
        didSet { shapeNode.strokeColor = keyColor }
    }

    // MARK: - Subnodes
    private let shapeNode = SKShapeNode()

    // MARK: - Initialization
    public init(startAnchor: CGPoint, size: CGSize) {
        self.startPoint = startAnchor

        let linearSegment = LinearRopeSegmentNode()
        linearSegment.endPoint = startAnchor.add(.init(x: 100, y: 0))

//        let initialSegment = BendAnchorSegmentNode(
//            startPoint: startPoint,
//            bendAnchor: .init(x: startPoint.x + 100, y: startPoint.y),
//            curveRadius: 50
//        )

        let circleSegment = CircleAnchorSegmentNode(
            circleCenter: linearSegment.endPoint.add(.init(x: 0, y: 50)),
            radius: 50,
            enterDirection: startPoint.difference(to: linearSegment.endPoint)
        )

        self.segments = .init(base: linearSegment)
        segments.push(circleSegment)

        super.init(texture: nil, color: .clear, size: size)

        addChild(shapeNode)
        shapeNode.strokeColor = keyColor
        shapeNode.lineWidth = 50
        shapeNode.lineCap = .round
        redrawAll()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func redrawAll() {
        var path = CGMutablePath()
        path.move(to: startPoint)

        segments.toArray().forEach { segment in
            path = segment.drawPath(path: path)
        }

        shapeNode.path = path
    }

    func updateEndPoint(_ endPoint: CGPoint, anchors: [CircleAnchor]) {
        segments.head.endPoint = endPoint
        redrawAll()
    }
}


