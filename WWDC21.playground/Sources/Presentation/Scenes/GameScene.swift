import SpriteKit

class GameScene: FlowableScene {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Nodes
    private lazy var gridWorld: GridWorldNode = .init(size: size, world: .init())
    private let emitter: RotatingEmitterNode = .init()
    private let firstStaticEmitter: EmitterNode = StaticEmitterNode()
    private let secondStaticEmitter: EmitterNode = StaticEmitterNode()

    override func configureScene() {
        super.configureScene()
        addChild(gridWorld)
        gridWorld.position = .init(x: -size.width / 2, y: -size.height / 2)
        gridWorld.placeElement(emitter, at: .init(xIndex: 11, yIndex: 11))
        gridWorld.placeElement(firstStaticEmitter, at: .init(xIndex: 2, yIndex: 7))
        gridWorld.placeElement(secondStaticEmitter, at: .init(xIndex: 2, yIndex: 14))

        timer = Timer.scheduledTimer(withTimeInterval: tickDuration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.tickUpdate()
        }
    }

    private func tickUpdate() {
        tickCount += 1
        gridWorld.onTick(tickCount: tickCount)
    }
}
