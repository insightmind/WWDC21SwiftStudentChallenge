import Foundation

struct GridMovableMirror: GridElement {
    var type: GridElementType { .movableMirror(self) }
    var position: GridPosition
    var secondPosition: GridPosition

    func generateNode(using world: GridPlacementReference) -> GridNode {
        return MovableMirrorNode(from: world.realPosition(for: position), to: world.realPosition(for: secondPosition))
    }
}
