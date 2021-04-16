import CoreGraphics

protocol GridWorldReference: AnyObject {
    func emitQuantum(from position: CGPoint, using direction: GridDirection, group: GridInteractionGroup)
    func setGroup(_ group: GridInteractionGroup, isEnabled: Bool)
}
