import SpriteKit

final class GridWorldNode: SKNode {
    // MARK: - Properties
    private let world: GridWorld
    private let realSize: CGSize

    // MARK: - Children
    private let elements: [GridNode] = []
    private lazy var gridNode: GridShapeNode = .init(gridSize: world.size, realSize: realSize)

    // MARK: - Initialization
    init(size: CGSize, world: GridWorld) {
        self.world = world
        self.realSize = size
        super.init()
        configureNode()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(gridNode)
    }

    // MARK: - Game Updates
    func onTick(tickCount: Int) {
        elements.forEach { $0.onTick(tickCount: tickCount) }
    }

    // MARK: - Element Placement
    func placeElement(at positon: GridPosition) {
        // TODO: Implement this
    }

    func emitQuantum(from position: GridPosition, using direction: GridDirection) {
        // TODO: Implement this
    }
}
