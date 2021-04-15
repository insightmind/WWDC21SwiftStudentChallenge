import SpriteKit

final class EmissionNode: GridNode {
    // MARK: - Properties
    private let lifeTime: TimeInterval = 100

    // MARK: - Childnodes
    private lazy var spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Emission")

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
        physicsBody?.allowsRotation = false
        physicsBody?.usesPreciseCollisionDetection = true
        zPosition = -1

        addChild(spriteNode)
        layoutNode()

        let lifetimeAction = SKAction.wait(forDuration: lifeTime)
        run(.sequence([lifetimeAction, SKAction.removeFromParent()]))
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
    }

    // MARK: - Movement
    func setMovement(direction: GridDirection) {
        let velocityFactor = CGPoint(x: 7.5 * CGFloat(sizePerGrid.width), y: 7.5 * CGFloat(sizePerGrid.height))
        physicsBody?.setMoveDirection(direction: direction, velocityFactor: velocityFactor)
        spriteNode.zRotation = 2 * .pi - direction.rotationInRadians
    }
}
