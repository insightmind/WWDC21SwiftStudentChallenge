import SpriteKit

class MovableMirrorNode: MirrorNode, GridInteractable {
    // MARK: - Properties
    private let firstPoint: CGPoint
    private let secondPoint: CGPoint
    private var slideProgress: CGFloat = 0.5

    // MARK: - Subnodes
    private let firstAnchorNode: SKShapeNode = .init(circleOfRadius: 5)
    private let secondAnchorNode: SKShapeNode = .init(circleOfRadius: 5)
    private let connectionNode: SKShapeNode = .init()

    // MARK: - Initialization
    init(from firstPoint: CGPoint, to secondPoint: CGPoint) {
        self.firstPoint = firstPoint
        self.secondPoint = secondPoint
        super.init()

        position = calculatePosition(for: 0.5)
        spriteNode.position = calculatePosition(for: slideProgress) - position

        configureNode()
    }

    // MARK: - Configure Node
    private func configureNode() {
        let path = UIBezierPath()
        path.move(to: firstPoint - position)
        path.addLine(to: secondPoint - position)
        connectionNode.path = path.cgPath
        connectionNode.strokeColor = .white
        connectionNode.lineWidth = 4
        connectionNode.alpha = 0.2
        connectionNode.blendMode = .replace
        addChild(connectionNode)

        addChild(firstAnchorNode)
        firstAnchorNode.position = firstPoint - position
        firstAnchorNode.fillColor = .white
        firstAnchorNode.alpha = 0.2
        firstAnchorNode.blendMode = .replace

        addChild(secondAnchorNode)
        secondAnchorNode.position = secondPoint - position
        secondAnchorNode.fillColor = .white
        secondAnchorNode.alpha = 0.2
        secondAnchorNode.blendMode = .replace
    }

    // MARK: - Helper Method
    private func calculatePosition(for progress: CGFloat) -> CGPoint {
        return .linearInterpolate(first: firstPoint, second: secondPoint, parameter: progress)
    }

    // MARK: - Interaction
    override func onTouchUp(at location: CGPoint) {
        super.onTouchUp(at: location)
        updatePosition(for: location)
    }

    override func onTouchDown(at location: CGPoint) {
        super.onTouchDown(at: location)
        updatePosition(for: location)
    }

    override func onTouchMove(at location: CGPoint) {
        super.onTouchMove(at: location)
        updatePosition(for: location)
    }

    private func updatePosition(for touchLocation: CGPoint) {
        let normalizedPosition = touchLocation - position
        guard spriteNode.contains(normalizedPosition) else { return }
        guard abs(secondPoint.x - firstPoint.x) + abs(secondPoint.y - firstPoint.y) > 0 else { return }

        let xProgress = max(0, min(1, abs(touchLocation.x - firstPoint.x) / abs(secondPoint.x - firstPoint.x)))
        let yProgress = max(0, min(1, abs(touchLocation.y - firstPoint.y) / abs(secondPoint.y - firstPoint.y)))

        if abs(secondPoint.x - firstPoint.x) <= 0 {
            slideProgress = yProgress
        } else if abs(secondPoint.y - firstPoint.y) <= 0 {
            slideProgress = xProgress
        } else {
            slideProgress = xProgress * 0.5 + yProgress * 0.5
        }

        spriteNode.position = calculatePosition(for: slideProgress) - position
        layoutNode()
    }
}
