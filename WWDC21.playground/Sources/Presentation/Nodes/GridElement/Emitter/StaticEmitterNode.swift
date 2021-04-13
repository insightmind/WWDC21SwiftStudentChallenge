import SpriteKit

final class StaticEmitterNode: EmitterNode {
    // MARK: - Properties
    override var emitDirection: GridDirection {
        didSet { reconfigureNode() }
    }

    // MARK: - Childnodes
    private let spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Emitter/Emitter_single")

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.size = sizePerGrid

        reconfigureNode()
    }

    private func reconfigureNode() {
        switch emitDirection {
        case .left:
            spriteNode.zRotation = .pi / 2

        case .up:
            spriteNode.zRotation = 0

        case .right:
            spriteNode.zRotation = -.pi / 2

        case .down:
            spriteNode.zRotation = .pi
        }
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
    }
}
