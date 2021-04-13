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
        let emission = EmissionNode()
        emission.zPosition = -1
        addChild(emission)

        animateEmitter()

        let waitAction = SKAction.wait(forDuration: 0.3)
        let moveAction = SKAction.move(by: .init(dx: emitDirection.vector.dx * 10 * sizePerGrid.width, dy: emitDirection.vector.dy * 10 * sizePerGrid.height), duration: 1.2)
        let removeAction = SKAction.removeFromParent()
        let groupAction = SKAction.sequence([waitAction, moveAction, removeAction])

        emission.run(groupAction)
    }

    private func animateEmitter() {
        let scaleDown = SKAction.scale(by: 0.95, duration: 0.3)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.1)
        let scaleReturn = SKAction.scale(to: 1, duration: 0.1)

        let sequence = SKAction.sequence([scaleDown, scaleUp, scaleReturn])

        self.run(sequence)
    }
}
