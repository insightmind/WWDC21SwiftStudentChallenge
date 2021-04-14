import SpriteKit

final class EmissionNode: GridNode {
    // MARK: - Childnodes
    private lazy var spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Emission")

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.color = .vividBlue
        spriteNode.colorBlendFactor = 1.0
        spriteNode.size = .init(width: sizePerGrid.width * 0.5, height: sizePerGrid.height * 0.5)

        physicsBody = .init(rectangleOf: .init(width: 1, height: 1))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0
        zPosition = -1
    }
}
