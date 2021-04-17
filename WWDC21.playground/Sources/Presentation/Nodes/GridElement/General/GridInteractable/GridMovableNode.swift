import SpriteKit

final class GridMovableNode: GridNode, GridInteractable {
    // MARK: - Properties
    private let firstPoint: CGPoint
    private let secondPoint: CGPoint
    private var slideProgress: CGFloat
    private var isInDrag: Bool = false

    override var isMuted: Bool {
        get { childNode.isMuted }
        set { childNode.isMuted = newValue }
    }

    // MARK: - Subnodes
    private let firstAnchorNode: SKShapeNode = .init(circleOfRadius: 5)
    private let secondAnchorNode: SKShapeNode = .init(circleOfRadius: 5)
    private let connectionNode: SKShapeNode = .init()
    private let childNode: GridNode

    // MARK: - Initialization
    init(from firstPoint: CGPoint, to secondPoint: CGPoint, initialProgress: CGFloat = 0.5, child: GridNode) {
        self.firstPoint = firstPoint
        self.secondPoint = secondPoint
        self.childNode = child
        self.slideProgress = max(0, min(1, initialProgress))

        super.init()

        position = calculatePosition(for: 0.5)
        childNode.position = calculatePosition(for: slideProgress) - position
        childNode.gridWorld = self

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
        connectionNode.zPosition = -10
        addChild(connectionNode)

        addChild(firstAnchorNode)
        firstAnchorNode.position = firstPoint - position
        firstAnchorNode.fillColor = .white
        firstAnchorNode.alpha = 0.2
        firstAnchorNode.blendMode = .replace
        firstAnchorNode.zPosition = -10

        addChild(secondAnchorNode)
        secondAnchorNode.position = secondPoint - position
        secondAnchorNode.fillColor = .white
        secondAnchorNode.alpha = 0.2
        secondAnchorNode.blendMode = .replace
        secondAnchorNode.zPosition = -10

        addChild(childNode)
    }

    override func layoutNode() {
        childNode.sizePerGrid = sizePerGrid
    }

    override func onTick(tickCount: Int) {
        childNode.onTick(tickCount: tickCount)
    }

    // MARK: - Helper Method
    private func calculatePosition(for progress: CGFloat) -> CGPoint {
        return .linearInterpolate(first: firstPoint, second: secondPoint, parameter: progress)
    }

    // MARK: - Interaction
    func onTouchUp(at location: CGPoint) {
        guard childNode.contains(location - position) else { return }
        updatePosition(for: location)
        isInDrag = false
    }

    func onTouchDown(at location: CGPoint) {
        guard childNode.contains(location - position) else { return }
        updatePosition(for: location)
        isInDrag = true
    }

    func onTouchMove(at location: CGPoint) {
        guard isInDrag else { return }
        updatePosition(for: location)
    }

    private func updatePosition(for touchLocation: CGPoint) {
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

        childNode.run(.move(to: calculatePosition(for: slideProgress) - position, duration: 0.1))
        layoutNode()
    }
}

extension GridMovableNode: GridWorldReference {
    func emitQuantum(from position: CGPoint, using direction: GridDirection, group: GridInteractionGroup) {
        gridWorld?.emitQuantum(from: position + self.position, using: direction, group: group)
    }

    func setGroup(_ group: GridInteractionGroup, isEnabled: Bool) {
        gridWorld?.setGroup(group, isEnabled: isEnabled)
    }
}
