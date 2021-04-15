import SpriteKit

class TransmitterNode: EmissionInteractingNode {
    // MARK: - Properties
    private var receiveCount: Int = 0

    // MARK: - Initialization
    init(receiveFrom receiveDirections: Set<GridDirection> = [], transmitTo transmitDirections: Set<GridDirection> = []) {
        super.init()
        self.receiveDirections = receiveDirections
        self.emitDirections = transmitDirections
    }

    // MARK: - Override
    override func handle(_ emission: EmissionNode) {
        super.handle(emission)
        receiveCount = (receiveCount + 1) % receiveDirections.count
    }

    override func emit() {
        guard receiveCount == 0 else { return }
        super.emit()
    }
}
