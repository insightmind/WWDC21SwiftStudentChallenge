import SpriteKit

class SimulationScene: MovableScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Nodes
    private let level: Level = .init(
        world: .init(size: .init(width: 20, height: 20)),
        emitter: [
            .init(position: .init(xIndex: 2, yIndex: 2), emitDirection: .up),
            .init(position: .init(xIndex: 2, yIndex: 12), emitDirection: .down)
        ],
        transmitter: [
            .init(position: .init(xIndex: 2, yIndex: 7), emitDirections: [.up, .down], receiveDirections: [.rightUp, .rightDown]),
            .init(position: .init(xIndex: 5, yIndex: 10), emitDirections: [.leftDown], receiveDirections: [.rightDown]),
            .init(position: .init(xIndex: 5, yIndex: 4), emitDirections: [.leftUp], receiveDirections: [.rightUp])
        ],
        receiver: [
            .init(position: .init(xIndex: 11, yIndex: 10), receiveDirection: .leftDown),
            .init(position: .init(xIndex: 11, yIndex: 4), receiveDirection: .leftUp)
        ],
        mirrors: [
            .init(position: .init(xIndex: 2, yIndex: 10), initialRotation: .down)
        ]
    )

    private lazy var gridWorld: GridWorldNode = .init(sizePerGrid: .init(width: 50, height: 50), world: level.world)

    override func configureScene() {
        super.configureScene()

        addChild(gridWorld)
        gridWorld.position = .init(x: -gridWorld.realSize.width / 2, y: -gridWorld.realSize.height / 2)
        playableArea = .init(origin: gridWorld.position, size: gridWorld.realSize)
        configurePhysicsWorld()

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
