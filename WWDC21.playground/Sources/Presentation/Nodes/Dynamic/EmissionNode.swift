import SpriteKit

final class EmissionNode: GridNode, EmissionInteractor {
    // MARK: - Properties
    private let lifeTime: TimeInterval = 100
    let group: GridInteractionGroup

    // MARK: - Childnodes
    private lazy var spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Emission")

    // MARK: - Initialization
    init(group: GridInteractionGroup) {
        self.group = group

        super.init()

        configureNode()
        layoutNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        zPosition = -1

        addChild(spriteNode)
        spriteNode.color = group.baseColor
        spriteNode.colorBlendFactor = 1.0
        layoutNode()

        let lifetimeAction = SKAction.wait(forDuration: lifeTime)
        run(.sequence([lifetimeAction, SKAction.removeFromParent()]))
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid

        physicsBody = .init(rectangleOf: .init(width: sizePerGrid.width, height: sizePerGrid.height / 8))
        physicsBody?.affectedByGravity = false
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.collideAll()
    }

    // MARK: - Movement
    func setMovement(direction: GridDirection) {
        let velocityFactor = CGPoint(x: 7.5 * CGFloat(sizePerGrid.width), y: 7.5 * CGFloat(sizePerGrid.height))
        physicsBody?.setMoveDirection(direction: direction, velocityFactor: velocityFactor)
        spriteNode.zRotation = 2 * .pi - direction.rotationInRadians
    }

    // MARK: - Emission Interactor
    func handle(_ emission: EmissionNode) {
        emission.removeFromParent()
        removeFromParent()
    }
}
