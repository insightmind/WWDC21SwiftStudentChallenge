import SpriteKit

class GameScene: FlowableScene {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.6
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Nodes
    private lazy var gridWorld: GridWorldNode = .init(size: size, world: .init())
    private let emitter: StaticEmitterNode = .init()

    override func configureScene() {
        super.configureScene()
        addChild(gridWorld)
        gridWorld.position = .init(x: -size.width / 2, y: -size.height / 2)

        addChild(emitter)

        timer = Timer.scheduledTimer(withTimeInterval: tickDuration, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.tickUpdate()
        }
    }

    private func tickUpdate() {
        tickCount += 1

        emitter.onTick(tickCount: tickCount)
    }
}
