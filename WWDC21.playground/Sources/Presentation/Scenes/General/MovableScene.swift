import SpriteKit

class MovableScene: FlowableScene {
    // MARK: - Properties
    private var previousCameraScale: CGFloat = 1.0
    private var previousCameraPosition: CGPoint = .init()
    var playableArea: CGRect = .init(x: -200, y: -200, width: 400, height: 400)

    override var isUserInteractionEnabled: Bool {
        get { return true }
        set { /* We do not allow to change user interactability of the scene */ }
    }

    // MARK: - Lifecycle
    override func configureScene() {
        super.configureScene()

        configureCamera()
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addPinchToZoomGesture()
        addDragGesture()
    }

    // MARK: - Configuration
    private func configureCamera() {
        let camera = SKCameraNode()
        addChild(camera)
        self.camera = camera
    }

    private func addPinchToZoomGesture() {
        let gestureRecognizer = UIPinchGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(onPinchGesture(_:)))
        view?.addGestureRecognizer(gestureRecognizer)
    }

    private func addDragGesture() {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(onDragGesture(_:)))
        gestureRecognizer.minimumNumberOfTouches = 2
        view?.addGestureRecognizer(gestureRecognizer)
    }
    

    // MARK: - Actions
    @objc
    private func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        guard let camera = camera else { return }

        switch sender.state {
        case .began:
            previousCameraScale = camera.xScale
            fallthrough

        default:
            let scale = previousCameraScale * 1 / sender.scale
            camera.setScale(min(1, max(0.5, scale)))
            updatePosition()
        }
    }

    @objc
    private func onDragGesture(_ sender: UIPanGestureRecognizer) {
        guard let camera = camera else { return }
        let translation = sender.translation(in: view)

        switch sender.state {
        case .began:
            previousCameraPosition = camera.position
            fallthrough

        default:
            let newPosition = CGPoint(x: previousCameraPosition.x - translation.x * camera.xScale, y: previousCameraPosition.y + translation.y * camera.yScale)
            camera.position = .init(
                x: max(playableArea.minX + frame.width * camera.xScale / 2 - 50, min(playableArea.maxX - frame.width * camera.xScale / 2 + 50, newPosition.x)),
                y: max(playableArea.minY + frame.height * camera.yScale / 2 - 50, min(playableArea.maxY - frame.height * camera.yScale / 2 + 50, newPosition.y))
            )
        }
    }

    private func updatePosition() {
        guard let camera = camera else { return }

        let newXPosition: CGFloat = max(playableArea.minX + frame.width * camera.xScale / 2 - 50, min(playableArea.maxX - frame.width * camera.xScale / 2 + 50, camera.position.x))
        let newYPosition: CGFloat = max(playableArea.minY + frame.height * camera.yScale / 2 - 50, min(playableArea.maxY - frame.height * camera.yScale / 2 + 50, camera.position.y))

        camera.position = .init(x: newXPosition, y: newYPosition)
    }
}

