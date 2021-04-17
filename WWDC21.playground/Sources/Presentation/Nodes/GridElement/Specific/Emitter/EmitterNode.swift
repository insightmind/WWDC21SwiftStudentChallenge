import SpriteKit

class EmitterNode: EmissionInteractingNode {
    // MARK: - Childnodes
    var emitInterval: Int = 8

    // MARK: - Initialization
    init(emitTo emitDirection: GridDirection) {
        super.init()
        emitDirections = [emitDirection]
    }

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else { return }
        emit()
    }
}
