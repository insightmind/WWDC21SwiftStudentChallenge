import SpriteKit

class MirrorNode: GridNode, GridInteractable {
    // MARK: - Subnodes
    let spriteNode = MirrorSpriteNode()
    let node: SKShapeNode = .init()

    // MARK: - Intialization
    override init() {
        super.init()

        addChild(spriteNode)
        addChild(node)
        node.lineWidth = 4
        node.strokeColor = .red

        layoutNode()
    }

    // MARK: - Nodelayout
    override func layoutNode() {
        spriteNode.sizePerGrid = sizePerGrid
    }

    // MARK: - User Interaction
    func onTouchUp(at location: CGPoint) {
        // No custom interaction allowed
    }

    func onTouchDown(at location: CGPoint) {
        let rotateAction = SKAction.rotate(byAngle: .pi / 4, duration: 0.2)
        rotateAction.timingMode = .easeInEaseOut

        spriteNode.run(rotateAction)
    }

    func onTouchMove(at location: CGPoint) {
        // No custom interaction allowed
    }
}
