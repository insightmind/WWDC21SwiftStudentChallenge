import SpriteKit

class EmitterNode: GridNode {
    // MARK: - Childnodes
    var emitDirection: GridDirection = .right
    var emitInterval: Int = 2

    override init() {
        super.init()
        zPosition = 100
    }

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else { return }
        emit()
    }

    func emit() {
        print("Emit Quantum!!! Direction: \(emitDirection)")

        let emission = EmissionNode()
        emission.zPosition = -1
        addChild(emission)

        let moveAction = SKAction.move(by: .init(dx: emitDirection.vector.dx * 10 * sizePerGrid.width, dy: emitDirection.vector.dy * 10 * sizePerGrid.height), duration: 1.2)
        let removeAction = SKAction.removeFromParent()
        let groupAction = SKAction.sequence([moveAction, removeAction])

        emission.run(groupAction)
    }
}
