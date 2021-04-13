import SpriteKit

final class StaticEmitterNode: EmitterNode {
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
    }
}
