import Foundation

struct GridReceiver: GridElement {
    var type: GridElementType { .receiver(self) }

    var position: GridPosition
    var receiveDirection: GridDirection

    func generateNode() -> GridNode {
        return ReceiverNode(receiveFrom: receiveDirection)
    }
}
