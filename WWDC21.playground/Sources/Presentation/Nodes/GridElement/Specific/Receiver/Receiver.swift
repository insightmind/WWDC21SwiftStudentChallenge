import SpriteKit

final class ReceiverNode: EmissionInteractingNode {
    // MARK: - Subnodes
    private let indicatorNode: SKSpriteNode = SKSpriteNode(imageNamed: "Images/Nodes/Receiver-Body-Indicator")
    private let timeout: TimeInterval = 2
    private var lastReceived: DispatchTime?

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
        let waitAction = SKAction.wait(forDuration: 0.7 * timeout)
        let lightOffAction = SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.2 * timeout)
        let sequence = SKAction.sequence([lightAction, waitAction, lightOffAction])
        indicatorNode.run(sequence)

        lastReceived = .now()
        gridWorld?.setGroup(group, isEnabled: true)
        super.handle(emission)
    }

    override func onTick(tickCount: Int) {
        guard let lastReceived = lastReceived else { return }
        let distance = DispatchTime.now().uptimeNanoseconds - lastReceived.uptimeNanoseconds
        let seconds = TimeInterval(distance / 1_000_000_000)

        guard seconds > timeout else { return }
        gridWorld?.setGroup(self.group, isEnabled: false)
        self.lastReceived = nil
    }
}
