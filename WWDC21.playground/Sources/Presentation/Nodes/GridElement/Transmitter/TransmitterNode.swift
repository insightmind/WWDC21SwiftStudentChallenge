import SpriteKit

class TransmitterNode: GridNode {
    // MARK: - Properties
    private var virtualEmitter: [EmitterNode] = []
    private var virtualAbsorber: [AbsorberNode] = []

    override init() {
        super.init()
        zPosition = 100
    }

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        virtualEmitter.forEach { $0.onTick(tickCount: tickCount) }
        virtualAbsorber.forEach { $0.onTick(tickCount: tickCount) }
    }
}
