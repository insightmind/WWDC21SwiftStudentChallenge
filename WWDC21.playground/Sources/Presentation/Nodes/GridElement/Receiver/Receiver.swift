import SpriteKit

final class ReceiverNode: EmissionInteractingNode {
    init(receiveFrom receiveDirection: GridDirection) {
        super.init()
        receiveDirections = [receiveDirection]
    }
}
