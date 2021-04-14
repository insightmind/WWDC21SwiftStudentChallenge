import SpriteKit

final class StaticEmitterNode: EmitterNode {
    // MARK: - Childnodes
    private let spriteNode: SKSpriteNode = .init(imageNamed: "Images/Nodes/Emitter/Emitter_single")

    // MARK: - Initialization
    init(emitTo emitDirection: GridDirection) {
        super.init()
        emitDirections = [emitDirection]
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.size = sizePerGrid

        reconfigureNode()
    }

    private func reconfigureNode() {
        guard let emitDirection = emitDirections.first else { return }
        spriteNode.zRotation = emitDirection.rotationInRadians + .pi / 2
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
    }
}
