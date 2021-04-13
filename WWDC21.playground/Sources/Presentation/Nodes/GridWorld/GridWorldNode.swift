import SpriteKit

final class GridWorldNode: SKNode {
    // MARK: - Properties
    private let world: GridWorld
    private let realSize: CGSize
    private var sizePerGrid: CGSize {
        return .init(width: realSize.width / CGFloat(world.size.width), height: realSize.height / CGFloat(world.size.height))
    }

    // MARK: - Children
    private var elements: [GridNode] = []
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
    func placeElement(_ element: GridNode, at position: GridPosition) {
        addChild(element)
        element.position = realPosition(for: position)
        element.sizePerGrid = sizePerGrid

        elements.append(element)
    }

    func emitQuantum(from position: GridPosition, using direction: GridDirection) {
        // TODO: Implement this
    }

    // MARK: - Helper Methods
    private func realPosition(for gridPosition: GridPosition) -> CGPoint {
        return .init(
            x: realSize.width * CGFloat(gridPosition.xIndex) / CGFloat(world.size.width) - sizePerGrid.width / 2,
            y: realSize.height * CGFloat(gridPosition.yIndex) / CGFloat(world.size.height) - sizePerGrid.height / 2
        )
    }
}
