import Foundation

struct GridReceiver: GridElement {
    var type: GridElementType { .receiver(self) }

    var position: GridPosition
    var receiveDirection: GridDirection

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = ReceiverNode(receiveFrom: receiveDirection)
        node.position = world.realPosition(for: position)
        return node
    }
}
