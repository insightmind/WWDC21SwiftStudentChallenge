import SpriteKit

final class ReceiverNode: EmissionInteractingNode {
    // MARK: - Subnode
    private lazy var shapeNode = SKShapeNode(rectOf: sizePerGrid)

    init(receiveFrom receiveDirection: GridDirection) {
        super.init()
        receiveDirections = [receiveDirection]
        addChild(shapeNode)
        shapeNode.fillColor = .cyan
    }

    override func layoutNode() {
        shapeNode.path = UIBezierPath(rect: .init(origin: .init(x: -sizePerGrid.width / 2, y: -sizePerGrid.height / 2), size: sizePerGrid)).cgPath
    }
}
