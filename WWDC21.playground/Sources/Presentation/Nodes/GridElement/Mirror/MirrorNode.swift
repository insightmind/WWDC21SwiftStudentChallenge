import SpriteKit

class MirrorNode: GridNode, EmissionInteractor {
    // MARK: - Subnodes
    private let spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Mirror-Both-Sides")

    // MARK: - Intialization
    override init() {
        super.init()

        addChild(spriteNode)
        layoutNode()
    }

    // MARK: - Nodelayout
    override func layoutNode() {
        spriteNode.size = sizePerGrid

        let rect = CGRect(origin: .init(x: -sizePerGrid.width / 2, y: -sizePerGrid.height / 2), size: sizePerGrid)
        physicsBody = SKPhysicsBody(edgeFrom: .init(x: rect.minX, y: rect.minY), to: .init(x: rect.maxX, y: rect.maxY))
        physicsBody?.isDynamic = false
        physicsBody?.receiveEmissions(from: GridDirection.allCases)
    }

    // MARK: - Emission Handling
    func handle(_ emission: EmissionNode) {
        guard let velocity = emission.physicsBody?.velocity else { return }
        print("MIRROR \(velocity)")
        //emission.physicsBody?.velocity = .init(dx: velocity.dy, dy: velocity.dx)
    }
}