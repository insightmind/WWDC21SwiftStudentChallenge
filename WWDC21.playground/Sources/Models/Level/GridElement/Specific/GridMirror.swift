import Foundation

struct GridMirror: GridElement {
    var type: GridElementType { .mirror(self) }
    
    var position: GridPosition
    var initialRotation: GridDirection

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = MirrorNode()
        node.position = world.realPosition(for: position)
        return node
    }
}
