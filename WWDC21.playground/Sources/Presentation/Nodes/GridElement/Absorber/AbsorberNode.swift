import SpriteKit

class AbsorberNode: GridNode {
    // MARK: - Childnodes
    var absorbedCount: Int = 0

    override init() {
        super.init()
        zPosition = 100
    }

    // MARK: - Game Updates
    override func onTick(tickCount: Int) {
        // TODO: Implement this
    }

    func absorb(emission: EmissionNode) {
        emission.removeFromParent()
    }
}
