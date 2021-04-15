import Foundation

struct GridEmitter: GridElement {
    var type: GridElementType { .emitter(self) }

    var position: GridPosition
    var emitDirection: GridDirection

    func generateNode() -> GridNode {
        return StaticEmitterNode(emitTo: emitDirection)
    }
}
