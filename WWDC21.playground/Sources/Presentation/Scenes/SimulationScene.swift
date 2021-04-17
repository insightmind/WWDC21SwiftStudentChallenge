import SpriteKit
import AVFoundation

class SimulationScene: MovableGameScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.1
    private var tickCount: Int = 0
    private var previousUpdateTime: TimeInterval = 0.0

    // MARK: - Public Properties
    var onCompletion: ((AvailableLevels) -> Void)?
    @Published var level: AvailableLevels = .level(index: 1) {
        didSet { transitionLevel(to: level) }
    }

    var isMuted: Bool {
        get { gridWorld.isMuted }
        set { gridWorld.isMuted = newValue }
    }

    override var playableArea: CGRect {
        get { CGRect(origin: gridWorld.position, size: gridWorld.realSize) }
        set { /* No updates allowed */ }
    }

    // MARK: - Nodes
    private var gridWorld: GridWorldNode = .init(sizePerGrid: .init(width: 50, height: 50))

    // MARK: - Configuration
    override func configureScene() {
        super.configureScene()

        backgroundColor = .black
        scaleMode = .aspectFill

        physicsWorld.contactDelegate = self

        loadLevel(level)
    }

    // MARK: - GameTick
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

        guard currentTime - previousUpdateTime > tickDuration else { return }
        previousUpdateTime = currentTime
        tickCount += 1
        gridWorld.onTick(tickCount: tickCount)
    }

    // MARK: - Public Methods
    private func loadLevel(_ level: AvailableLevels) {
        // Remove previous level
        gridWorld.removeFromParent()

        // Create new level area
        gridWorld = .init(sizePerGrid: .init(width: 50, height: 50))
        gridWorld.delegate = self
        addChild(gridWorld)

        // Load level if possible
        guard let level = level.load() else { return }
        gridWorld.loadLevel(level)

        updatePosition()
    }

    private func transitionLevel(to level: AvailableLevels) {
        let waitAction = SKAction.wait(forDuration: 0.5)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let loadLevelAction = SKAction.customAction(withDuration: 0.0) { [weak self] _, _ in
            self?.loadLevel(level)
            self?.gridWorld.alpha = 0.0

            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            self?.gridWorld.run(fadeInAction)
        }

        gridWorld.run(.sequence([waitAction, fadeOutAction, loadLevelAction]))
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

extension SimulationScene: GridWorldDelegate {
    func didFinishLevel() {
        self.onCompletion?(level)
    }
}
