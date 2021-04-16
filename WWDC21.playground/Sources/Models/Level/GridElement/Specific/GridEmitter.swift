import Foundation

struct GridEmitter: GridElement {
    var type: GridElementType { .emitter(self) }

    var position: GridPosition
    var emitDirection: GridDirection
    var emissionGroup: GridInteractionGroup

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = StaticEmitterNode(emitTo: emitDirection)
        node.group = emissionGroup
        node.position = world.realPosition(for: position)
        return node
    }
}
