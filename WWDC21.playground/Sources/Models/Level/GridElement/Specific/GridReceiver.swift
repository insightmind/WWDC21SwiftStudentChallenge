import Foundation

struct GridReceiver: GridElement {
    var type: GridElementType { .receiver(self) }

    var position: GridPosition
    var receiveDirection: GridDirection
    var receiveGroup: GridInteractionGroup

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = ReceiverNode(receiveFrom: receiveDirection, group: receiveGroup)
        node.position = world.realPosition(for: position)
        return node
    }
}
