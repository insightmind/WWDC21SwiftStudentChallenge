import SpriteKit

final class EmissionNode: GridNode {
    // MARK: - Childnodes
    //private lazy var spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Emission/Emission")
    private lazy var shapeNode = SKShapeNode(circleOfRadius: sizePerGrid.width / 8)

    var moveDirection: GridDirection = .right

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(shapeNode)
        shapeNode.fillColor = .flickrPink
        shapeNode.strokeColor = .flickrPink
    }
}
