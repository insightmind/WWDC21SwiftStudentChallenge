import Foundation

struct GridGroupWall: GridElement {
    var type: GridElementType { .groupWall(self) }
    var position: GridPosition
    var group: GridInteractionGroup

    func generateNode(using world: GridPlacementReference) -> GridNode {
        let node = GroupWallNode(group: group)
        node.position = world.realPosition(for: position)
        return node
    }
}
