import Foundation

struct GridWall: GridElement {
    var type: GridElementType { .wall(self) }
    var position: GridPosition
    var movableOption: GridMovableOption?

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = WallNode()
        node.position = world.realPosition(for: position)
        return node
    }
}
