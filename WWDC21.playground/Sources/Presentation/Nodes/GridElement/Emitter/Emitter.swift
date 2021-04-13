import SpriteKit

class Emitter: GridNode {
    // MARK: - Childnodes
    private let shapeNode: SKShapeNode = .init(rect: .init(origin: .zero, size: .init(width: 25, height: 25)))

    var emitDirection: GridDirection = .right
    var emitInterval: Int = 2

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        shapeNode.fillColor = .flickrPink
        addChild(shapeNode)
    }

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else { return }
        // TODO: Emit Quantum
    }
}
