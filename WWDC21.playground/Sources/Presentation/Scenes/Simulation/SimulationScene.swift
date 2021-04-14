import SpriteKit

class SimulationScene: MovableScene {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Nodes
    private lazy var gridWorld: GridWorldNode = .init(size: size, world: .init())

    private let cameraNode: SKCameraNode = .init()
    private let firstStaticEmitter: EmitterNode = StaticEmitterNode(emitTo: .up)
    private let secondStaticEmitter: EmitterNode = StaticEmitterNode(emitTo: .down)

    private let transmitter: TransmitterNode = TransmitterNode(receiveFrom: [.up, .down], transmitTo: [.rightUp, .rightDown])
    private let transmitterTopNode: TransmitterNode = TransmitterNode(receiveFrom: [.leftDown], transmitTo: [.rightDown])
    private let transmitterBottomNode: TransmitterNode = TransmitterNode(receiveFrom: [.leftUp], transmitTo: [.rightUp])

    private let receiverTop: ReceiverNode = ReceiverNode(receiveFrom: .leftDown)
    private let receiverBottom: ReceiverNode = ReceiverNode(receiveFrom: .leftUp)

    private let mirror: MirrorNode = MirrorNode()

    override func configureScene() {
        super.configureScene()

        addChild(cameraNode)
        camera = cameraNode

        addChild(gridWorld)
        gridWorld.realSize = .init(width: min(size.height, size.width), height: min(size.height, size.width))
        gridWorld.position = .init(x: -size.width / 2, y: -size.height / 2)

        // BEGIN: DEBUG NODES
        gridWorld.placeElement(firstStaticEmitter, at: .init(xIndex: 2, yIndex: 2))
        gridWorld.placeElement(secondStaticEmitter, at: .init(xIndex: 2, yIndex: 12))

        gridWorld.placeElement(transmitter, at: .init(xIndex: 2, yIndex: 7))
        gridWorld.placeElement(transmitterTopNode, at: .init(xIndex: 5, yIndex: 10))
        gridWorld.placeElement(transmitterBottomNode, at: .init(xIndex: 5, yIndex: 4))

        gridWorld.placeElement(receiverTop, at: .init(xIndex: 11, yIndex: 10))
        gridWorld.placeElement(receiverBottom, at: .init(xIndex: 11, yIndex: 4))

        gridWorld.placeElement(mirror, at: .init(xIndex: 2, yIndex: 10))
        // END: DEBUG NODES
        
        configurePhysicsWorld()

        timer = Timer.scheduledTimer(withTimeInterval: tickDuration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.tickUpdate()
        }
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        gridWorld.realSize = .init(width: min(size.height, size.width), height: min(size.height, size.width))
        gridWorld.position = .init(x: -size.width / 2, y: -size.height / 2)
    }

    private func configurePhysicsWorld() {
        physicsWorld.contactDelegate = self
    }

    private func tickUpdate() {
        tickCount += 1
        gridWorld.onTick(tickCount: tickCount)
    }
}

extension SimulationScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let emissionNode: EmissionNode = (contact.bodyA.node as? EmissionNode) ?? (contact.bodyB.node as? EmissionNode) else { return }
        guard let interactorNode: EmissionInteractor = (contact.bodyA.node as? EmissionInteractor) ?? (contact.bodyB.node as? EmissionInteractor) else { return }
        interactorNode.handle(emissionNode)
    }
}
