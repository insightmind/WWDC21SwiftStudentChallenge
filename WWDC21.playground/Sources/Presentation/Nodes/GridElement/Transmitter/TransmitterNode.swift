import SpriteKit

class TransmitterNode: EmissionInteractingNode {
    // MARK: - Subnode
    private lazy var shapeNode = SKShapeNode(rectOf: sizePerGrid)

    // MARK: - Properties
    init(receiveFrom receiveDirections: Set<GridDirection> = [], transmitTo transmitDirections: Set<GridDirection> = []) {
        super.init()
        self.receiveDirections = receiveDirections
        self.emitDirections = transmitDirections

        addChild(shapeNode)
        shapeNode.fillColor = .red
    }

    override func layoutNode() {
        shapeNode.path = UIBezierPath(rect: .init(origin: .init(x: -sizePerGrid.width / 2, y: -sizePerGrid.height / 2), size: sizePerGrid)).cgPath
    }
}
