import Foundation

protocol GridElement: Codable {
    var type: GridElementType { get }
    var position: GridPosition { get }
    var movableOption: GridMovableOption? { get }

    func generateNode(using world: GridPlacementReference) -> GridNode
}

extension GridElement {
    func generatePlaceableNode(using world: GridPlacementReference) -> GridNode {
        if let option = movableOption {
            return GridMovableNode(
                from: world.realPosition(for: position),
                to: world.realPosition(for: option.secondPosition),
                initialProgress: option.initialProgress,
                child: generateNode(using: world)
            )
        } else {
            return generateNode(using: world)
        }
    }
}
