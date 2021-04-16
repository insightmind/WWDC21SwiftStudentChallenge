import CoreGraphics

protocol GridPlacementReference: AnyObject {
    func realPosition(for gridPosition: GridPosition) -> CGPoint
}
