import SpriteKit

class MirrorSpriteNode: GridNode, EmissionInteractor {
    // MARK: - Subnodes
    let spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Mirror-Both-Sides")
    let node: SKShapeNode = .init()

    // MARK: - Intialization
    override init() {
        super.init()

        zPosition = 10
        addChild(spriteNode)
        addChild(node)

        node.strokeColor = .red
        node.lineWidth = 3
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
        physicsBody = SKPhysicsBody(edgeFrom: .init(x: 0, y: -sizePerGrid.height / 4), to: .init(x: 0, y: sizePerGrid.height / 4))
        physicsBody?.isDynamic = false
        physicsBody?.receiveEmissions(from: GridDirection.allCases)
    }

    // MARK: - Emission Handling
    func handle(_ emission: EmissionNode) {
        emission.setMovement(direction: .left)
    }
}
