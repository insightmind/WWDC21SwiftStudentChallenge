import SpriteKit

final class WallNode: GridNode, EmissionInteractor {
    // MARK; - Subnodes
    private let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Wall")

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configure Nodes
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.anchorPoint = .init(x: 0.5, y: 0.5)
        layoutNode()
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
        physicsBody = .init(rectangleOf: sizePerGrid)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.collideAll()
    }

    // MARK: - Emission Handling
    func handle(_ emission: EmissionNode) {
        emission.removeFromParent()
    }
}
