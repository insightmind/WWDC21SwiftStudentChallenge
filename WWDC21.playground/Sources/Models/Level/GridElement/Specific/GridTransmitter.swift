import Foundation

struct GridTransmitter: GridElement {
    var type: GridElementType { .transmitter(self) }

    var position: GridPosition

    var emitDirections: [GridDirection]
    var receiveDirections: [GridDirection]

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = TransmitterNode(receiveFrom: .init(receiveDirections), transmitTo: .init(emitDirections))
        node.position = world.realPosition(for: position)
        return node
    }
}
