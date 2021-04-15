import Foundation

struct GridTransmitter: GridElement {
    var type: GridElementType { .transmitter(self) }

    var position: GridPosition

    var emitDirections: [GridDirection]
    var receiveDirections: [GridDirection]

    func generateNode() -> GridNode {
        return TransmitterNode(receiveFrom: .init(receiveDirections), transmitTo: .init(emitDirections))
    }
}
