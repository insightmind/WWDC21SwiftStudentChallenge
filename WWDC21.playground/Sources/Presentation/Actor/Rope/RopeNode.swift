// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

public class RopeNode: SKSpriteNode {
    // MARK: - Properties
    private var segments: NonEmptyStack<RopeSegmentNode>
    var keyColor: UIColor = .charcoal {
        didSet {
            segments
                .toArray()
                .forEach { $0.keyColor = keyColor }
        }
    }

    // MARK: - Initialization
    public init(startAnchor: CGPoint, size: CGSize) {
        let linearSegment = LinearRopeSegmentNode(startPoint: startAnchor)
        linearSegment.endPoint = linearSegment.startPoint.add(.init(x: 100, y: 0))

//        let initialSegment = BendAnchorSegmentNode(
//            startPoint: startPoint,
//            bendAnchor: .init(x: startPoint.x + 100, y: startPoint.y),
//            curveRadius: 50
//        )

        let initialSegment = CircleAnchorSegmentNode(startPoint: linearSegment.endPoint, startPointToAnchorDirection: .init(x: 0, y: 50), enterDirection: .init(x: 1, y: 0))

        self.segments = .init(base: linearSegment)
        super.init(texture: nil, color: .clear, size: size)
        addChild(linearSegment)


        addSegment(initialSegment)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    private func redrawAll() {
        segments.toArray().forEach { $0.redraw() }
    }

    public func updateEndPoint(_ endPoint: CGPoint) {
        segments.head.endPoint = endPoint
    }

    private func addSegment(_ segment: RopeSegmentNode) {
        segments.push(segment)
        addChild(segment)
    }
}


