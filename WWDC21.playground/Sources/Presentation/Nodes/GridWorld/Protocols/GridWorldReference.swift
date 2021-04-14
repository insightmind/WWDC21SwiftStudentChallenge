import Foundation

protocol GridWorldReference: AnyObject {
    func emitQuantum(from position: GridPosition, using direction: GridDirection)
    func position(of element: GridNode) -> GridPosition
}
