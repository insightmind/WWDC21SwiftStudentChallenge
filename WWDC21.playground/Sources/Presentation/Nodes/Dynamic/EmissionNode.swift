import SpriteKit

final class EmissionNode: SKNode {
    // MARK: - Childnodes
    private lazy var spriteNode: SKSpriteNode = SKSpriteNode(fileNamed: "Images/Nodes/Emission/Emission")!

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
    }
}
