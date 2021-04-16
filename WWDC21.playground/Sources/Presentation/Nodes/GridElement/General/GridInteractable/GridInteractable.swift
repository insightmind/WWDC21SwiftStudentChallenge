import CoreGraphics

protocol GridInteractable: GridNode {
    func onTouchDown(at location: CGPoint)
    func onTouchMove(at location: CGPoint)
    func onTouchUp(at location: CGPoint)
}

extension GridInteractable {
    func onTouchDown(at location: CGPoint) {
        position = location
    }

    func onTouchMove(at location: CGPoint) {
        position = location
    }

    func onTouchUp(at location: CGPoint) {
        position = location
    }
}
