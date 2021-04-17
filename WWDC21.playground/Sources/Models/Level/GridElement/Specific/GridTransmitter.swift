import Foundation

struct GridTransmitter: GridElement {
    var type: GridElementType { .transmitter(self) }

    var position: GridPosition

    var emitDirections: [GridDirection]
    var receiveDirections: [GridDirection]
    var movableOption: GridMovableOption?
    var emissionGroup: GridInteractionGroup

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = TransmitterNode(receiveFrom: .init(receiveDirections), transmitTo: .init(emitDirections), group: emissionGroup)
        node.position = world.realPosition(for: position)
        return node
    }
}
