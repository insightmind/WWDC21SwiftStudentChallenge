import Foundation

struct GridTransmitter: GridElement {
    var position: GridPosition

    var emitDirections: [GridDirection]
    var receiveDirections: [GridDirection]
}
