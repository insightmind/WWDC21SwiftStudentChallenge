import SpriteKit

class SimulationScene: MovableScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.1
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Nodes
    private lazy var gridWorld: GridWorldNode = .init(sizePerGrid: .init(width: 50, height: 50))

    override func configureScene() {
        super.configureScene()
        configurePhysicsWorld()

        backgroundColor = .black
        scaleMode = .aspectFill

        guard let level = AvailableLevels.level(index: 1).load() else { return }
        addChild(gridWorld)
        gridWorld.loadLevel(level)

        gridWorld.position = .init(x: -gridWorld.realSize.width / 2, y: -gridWorld.realSize.height / 2)
        playableArea = .init(origin: gridWorld.position, size: gridWorld.realSize)
        timer = Timer.scheduledTimer(withTimeInterval: tickDuration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.tickUpdate()
        }
    }

    private func configurePhysicsWorld() {
        physicsWorld.contactDelegate = self
    }

    private func tickUpdate() {
        tickCount += 1
        gridWorld.onTick(tickCount: tickCount)
    }

    // MARK: - User Interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: gridWorld)
        let interactableNodes = findInteractableNodes(at: location)
        interactableNodes.forEach { $0.onTouchDown(at: location) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: gridWorld)
        let interactableNodes = findInteractableNodes(at: location)
        interactableNodes.forEach { $0.onTouchMove(at: location) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: gridWorld)
        let interactableNodes = findInteractableNodes(at: location)
        interactableNodes.forEach { $0.onTouchUp(at: location) }
    }

    private func findInteractableNodes(at position: CGPoint) -> [GridInteractable] {
        return gridWorld.nodes(at: position)
            .compactMap { $0 as? GridInteractable }
    }

    // MARK: - SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        guard let emissionNode: EmissionNode = (contact.bodyA.node as? EmissionNode) ?? (contact.bodyB.node as? EmissionNode) else { return }
        guard let interactorNode: EmissionInteractor = (contact.bodyA.node as? EmissionInteractor) ?? (contact.bodyB.node as? EmissionInteractor) else { return }
        interactorNode.handle(emissionNode)
    }
}
