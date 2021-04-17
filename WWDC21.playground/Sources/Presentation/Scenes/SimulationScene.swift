import SpriteKit
import AVFoundation

class SimulationScene: MovableGameScene, SKPhysicsContactDelegate {
    // MARK: - Properties
    private let tickDuration: TimeInterval = 0.1
    private var tickCount: Int = 0
    private var timer: Timer?

    // MARK: - Public Properties
    let level: AvailableLevels
    var onCompletion: ((AvailableLevels) -> Void)?

    var isMuted: Bool {
        get { gridWorld.isMuted }
        set { gridWorld.isMuted = newValue }
    }

    override var playableArea: CGRect {
        get { CGRect(origin: gridWorld.position, size: gridWorld.realSize) }
        set { /* No updates allowed */ }
    }

    // MARK: - Nodes
    private var gridWorld: GridWorldNode = .init(sizePerGrid: .init(width: 50, height: 50), level: .init())

    // MARK: - Initialization
    init(size: CGSize, level: AvailableLevels) {
        self.level = level
        super.init(size: size)
    }

    // MARK: - Configuration
    override func configureScene() {
        super.configureScene()

        backgroundColor = .black
        scaleMode = .aspectFill
        physicsWorld.contactDelegate = self
        isPaused = true

        loadLevel(level)

        timer = .scheduledTimer(withTimeInterval: tickDuration, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }

            guard !self.isPaused else { return }

            self.tickCount += 1
            self.gridWorld.onTick(tickCount: self.tickCount)
        }
    }

    // MARK: - Public Methods
    private func loadLevel(_ level: AvailableLevels) {
        // Load level if possible
        guard let level = level.load() else { return }
        // Create new level area
        gridWorld = .init(sizePerGrid: .init(width: 50, height: 50), level: level)
        addChild(gridWorld)
        gridWorld.delegate = self

        physicsWorld.contactDelegate = self
        audioEngine.mainMixerNode.outputVolume = 0.2

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
