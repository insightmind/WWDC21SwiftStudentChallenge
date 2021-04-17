import Foundation

struct GridEmitter: GridElement {
    var type: GridElementType { .emitter(self) }

    var position: GridPosition
    var emitDirection: GridDirection
    var emissionGroup: GridInteractionGroup
    var movableOption: GridMovableOption?

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = EmitterNode(emitTo: emitDirection)
        node.group = emissionGroup
        node.position = world.realPosition(for: position)
        return node
    }
}
