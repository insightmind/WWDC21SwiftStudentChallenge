import Foundation

protocol GridElement: Codable {
    var type: GridElementType { get }
    var position: GridPosition { get }

    func generateNode(using world: GridPlacementReference) -> GridNode
}
