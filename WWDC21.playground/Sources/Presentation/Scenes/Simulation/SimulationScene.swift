import SpriteKit

class SimulationScene: MovableScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    private let level: Level = .init(
        world: .init(size: .init(width: 13, height: 13)),
        elements: [
            GridEmitter(position: .init(xIndex: 2, yIndex: 2), emitDirection: .up),
            GridEmitter(position: .init(xIndex: 2, yIndex: 12), emitDirection: .down),

            GridTransmitter(position: .init(xIndex: 2, yIndex: 7), emitDirections: [.rightUp, .rightDown], receiveDirections: [.up, .down]),
            GridTransmitter(position: .init(xIndex: 5, yIndex: 10), emitDirections: [.rightDown], receiveDirections: [.leftDown]),
            GridTransmitter(position: .init(xIndex: 5, yIndex: 4), emitDirections: [.rightUp], receiveDirections: [.leftUp]),

            GridReceiver(position: .init(xIndex: 11, yIndex: 10), receiveDirection: .leftDown),
            GridReceiver(position: .init(xIndex: 11, yIndex: 4), receiveDirection: .leftUp),

            GridMirror(position: .init(xIndex: 8, yIndex: 7), initialRotation: .down)
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

    // MARK: - SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        guard let emissionNode: EmissionNode = (contact.bodyA.node as? EmissionNode) ?? (contact.bodyB.node as? EmissionNode) else { return }
        guard let interactorNode: EmissionInteractor = (contact.bodyA.node as? EmissionInteractor) ?? (contact.bodyB.node as? EmissionInteractor) else { return }
        interactorNode.handle(emissionNode)
    }
}
