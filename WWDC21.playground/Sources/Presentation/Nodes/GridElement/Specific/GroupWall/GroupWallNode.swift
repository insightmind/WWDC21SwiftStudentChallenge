import SpriteKit

final class GroupWallNode: GridNode, EmissionInteractor, GroupUpdatable {
    // MARK; - Subnodes
    private let spriteNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/GroupWall")
    private let group: GridInteractionGroup
    private var isEnabled: Bool = true {
        didSet {
            spriteNode.run(.fadeAlpha(to: isEnabled ? 1.0 : 0.2, duration: 0.4))
        }
    }

    // MARK: - Initialization
    init(group: GridInteractionGroup) {
        self.group = group
        super.init()
        configureNode()
    }

    // MARK: - Configure Nodes
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.anchorPoint = .init(x: 0.5, y: 0.5)
        spriteNode.colorBlendFactor = isEnabled ? 1.0 : 0.2
        spriteNode.color = group.baseColor

        layoutNode()
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
        physicsBody = .init(rectangleOf: sizePerGrid)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.collideAll()
    }

    // MARK: - Emission Handling
    func handle(_ emission: EmissionNode) {
        if isEnabled && emission.group != group {
            emission.removeFromParent()
        }
    }

    // MARK: - Group Updatable
    func onGroupUpdate(enabledGroups: Set<GridInteractionGroup>) {
        isEnabled = !enabledGroups.contains(group)
    }
}


