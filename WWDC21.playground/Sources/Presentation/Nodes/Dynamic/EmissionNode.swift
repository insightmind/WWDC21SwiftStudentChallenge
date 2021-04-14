import SpriteKit

final class EmissionNode: GridNode {
    // MARK: - Childnodes
    private lazy var spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Emission")
    private lazy var glowNode: SKShapeNode = .init()

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
        layoutNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.color = .vividBlue
        spriteNode.colorBlendFactor = 1.0
        spriteNode.isLigthningEnabled = true
        spriteNode.zPosition = 0

        physicsBody = .init(rectangleOf: .init(width: 1, height: 1))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0
        zPosition = -1

        addChild(glowNode)
        glowNode.fillColor = .vividBlue
        glowNode.strokeColor = .vividBlue
        glowNode.alpha = 0.1
        glowNode.zPosition = -1
        glowNode.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 2, height: 1))).cgPath
        glowNode.blendMode = .add
    }

    override func layoutNode() {
        spriteNode.size = .init(width: sizePerGrid.width * 0.7, height: sizePerGrid.height * 0.7)
        glowNode.glowWidth = min(sizePerGrid.width, sizePerGrid.height)
    }
}
