import SpriteKit

class TransmitterNode: EmissionInteractingNode {
    // MARK: - Properties
    init(receiveFrom receiveDirections: Set<GridDirection> = [], transmitTo transmitDirections: Set<GridDirection> = []) {
        super.init()
        self.receiveDirections = receiveDirections
        self.emitDirections = transmitDirections
    }
}
