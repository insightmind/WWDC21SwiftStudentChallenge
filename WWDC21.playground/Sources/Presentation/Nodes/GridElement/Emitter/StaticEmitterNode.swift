import SpriteKit

final class StaticEmitterNode: EmitterNode {
    // MARK: - Initialization
    init(emitTo emitDirection: GridDirection) {
        super.init()
        emitDirections = [emitDirection]
    }
}
