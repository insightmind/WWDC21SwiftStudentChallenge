import SpriteKit

final class EmissionNode: GridNode {
    // MARK: - Childnodes
    private lazy var glowNode: SKShapeNode = .init()

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
        layoutNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        physicsBody = .init(rectangleOf: .init(width: 1, height: 1))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0
        zPosition = -1

        addChild(glowNode)
        glowNode.fillColor = UIColor.vividBlue
        glowNode.strokeColor = UIColor.vividBlue.withAlphaComponent(0.1)
        glowNode.zPosition = -1
        glowNode.glowWidth = 10
    }

    override func layoutNode() {
        let size = CGSize(width: sizePerGrid.width / 4, height: sizePerGrid.height / 4)
        glowNode.path = UIBezierPath(ovalIn: .init(origin: .init(x: -size.width / 2, y: -size.height / 2), size: size)).cgPath
    }
}
