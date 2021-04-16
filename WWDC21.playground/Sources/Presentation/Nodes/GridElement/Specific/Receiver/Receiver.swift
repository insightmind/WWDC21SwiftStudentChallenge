import SpriteKit

final class ReceiverNode: EmissionInteractingNode {
    // MARK: - Subnodes
    private let indicatorNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Receiver-Body-Indicator")
    private let timeout: TimeInterval = 5.0
    private var timer: Timer?

    // MARK: - Initialization
    init(receiveFrom receiveDirection: GridDirection, group: GridInteractionGroup) {
        super.init()
        self.group = group
        self.receiveDirections = [receiveDirection]

        configureNode()
        layoutNode()
    }

    // MARK: - Node configuration
    private func configureNode() {
        indicatorNode.colorBlendFactor = 0.0
        indicatorNode.color = group.baseColor
        indicatorNode.anchorPoint = .init(x: 0.5, y: 0.5)
        indicatorNode.zPosition = 10
    }

    override func layoutNode() {
        super.layoutNode()

        addChild(indicatorNode)
        indicatorNode.size = sizePerGrid
    }

    override func handle(_ emission: EmissionNode) {
        guard emission.group == group else {
            emission.removeFromParent()
            return
        }

        indicatorNode.removeAllActions()
        let lightAction = SKAction.colorize(withColorBlendFactor: 1.0, duration: 0.1 * timeout)
        let lightOffAction = SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.9 * timeout)
        let sequence = SKAction.sequence([lightAction, lightOffAction])
        indicatorNode.run(sequence)

        timer?.invalidate()
        gridWorld?.setGroup(group, isEnabled: true)
        timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] timer in
            timer.invalidate()

            guard let self = self else { return }
            self.gridWorld?.setGroup(self.group, isEnabled: false)
        }

        super.handle(emission)
    }
}
