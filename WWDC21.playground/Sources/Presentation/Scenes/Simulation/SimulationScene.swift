import SpriteKit

class SimulationScene: MovableScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    override var isUserInteractionEnabled: Bool {
        get { return true }
        set { /* We do not allow to change user interactability of the scene */ }
    }

    private let level: Level = .init(
        world: .init(size: .init(width: 13, height: 13)),
        elements: [
            GridEmitter(position: .init(xIndex: 2, yIndex: 2), emitDirection: .up, emissionGroup: .green),
            GridEmitter(position: .init(xIndex: 2, yIndex: 12), emitDirection: .down, emissionGroup: .red),

            GridTransmitter(position: .init(xIndex: 2, yIndex: 7), emitDirections: [.rightUp, .rightDown], receiveDirections: [.up, .down]),
            GridTransmitter(position: .init(xIndex: 5, yIndex: 10), emitDirections: [.rightDown], receiveDirections: [.leftDown]),
            GridTransmitter(position: .init(xIndex: 5, yIndex: 4), emitDirections: [.rightUp], receiveDirections: [.leftUp]),

            GridReceiver(position: .init(xIndex: 11, yIndex: 10), receiveDirection: .leftDown),
            GridReceiver(position: .init(xIndex: 11, yIndex: 4), receiveDirection: .leftUp),

            GridWall(position: .init(xIndex: 8, yIndex: 13)),
            GridWall(position: .init(xIndex: 8, yIndex: 12)),
            GridWall(position: .init(xIndex: 8, yIndex: 11)),
            GridWall(position: .init(xIndex: 8, yIndex: 10)),

            GridWall(position: .init(xIndex: 8, yIndex: 4)),
            GridWall(position: .init(xIndex: 8, yIndex: 3)),
            GridWall(position: .init(xIndex: 8, yIndex: 2)),
            GridWall(position: .init(xIndex: 8, yIndex: 1)),

            GridMovableMirror(position: .init(xIndex: 8, yIndex: 9), secondPosition: .init(xIndex: 8, yIndex: 5))
        ]
    )

    // MARK: - Nodes
    private lazy var gridWorld: GridWorldNode = .init(sizePerGrid: .init(width: 50, height: 50), world: level.world)

    override func configureScene() {
        super.configureScene()
        configurePhysicsWorld()

        addChild(gridWorld)
        gridWorld.position = .init(x: -gridWorld.realSize.width / 2, y: -gridWorld.realSize.height / 2)
        gridWorld.loadLevel(level)
        level.printPretty()

        scaleMode = .aspectFill

        playableArea = .init(origin: gridWorld.position, size: gridWorld.realSize)
        backgroundColor = .black

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
