import CoreGraphics

protocol GridWorldReference: AnyObject {
    func emitQuantum(from position: GridPosition, using direction: GridDirection, group: GridInteractionGroup)
    func position(of element: GridNode) -> GridPosition
}
