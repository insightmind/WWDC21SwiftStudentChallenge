import SpriteKit

class EmitterNode: EmissionInteractingNode {
    // MARK: - Childnodes
    var emitInterval: Int = 5

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else { return }
        emit()
    }
}
