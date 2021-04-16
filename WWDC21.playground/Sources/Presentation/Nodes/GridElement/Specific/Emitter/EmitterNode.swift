import SpriteKit

class EmitterNode: EmissionInteractingNode {
    // MARK: - Childnodes
    var emitInterval: Int = 2

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else { return }
        emit()
    }
}
