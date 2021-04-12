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
        let startPoint = startAnchor.transform(by: .init(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

        let initialSegment = BendAnchorSegmentNode(
            startPoint: startPoint,
            bendAnchor: .init(x: startPoint.x + 100, y: startPoint.y),
            curveRadius: 50
        )

        segments = .init(base: initialSegment)

        super.init(texture: nil, color: .clear, size: size)

        addChild(segments.head)
        segments.head.position = segments.head.startPoint
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    public func updateEndPoint(_ endPoint: CGPoint) {
        segments.head.endPoint = endPoint
    }
}


