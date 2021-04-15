import SpriteKit

final class GridWorldNode: SKNode {
    // MARK: - Properties
    private let world: GridWorld
    var realSize: CGSize { .init(width: CGFloat(world.size.width) * sizePerGrid.width, height: sizePerGrid.height * CGFloat(world.size.height)) }
    var sizePerGrid: CGSize = .init(width: 30, height: 30) {
        didSet { layoutWorld() }
    }

    // MARK: - Children
    private var elements: [GridNode] = []
    private lazy var gridNode: GridShapeNode = .init(gridSize: world.size, realSize: realSize)

    // MARK: - Initialization
    init(sizePerGrid: CGSize, world: GridWorld) {
        self.world = world
        self.sizePerGrid = sizePerGrid
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
        gridNode.zPosition = -100
    }

    private func layoutWorld() {
        gridNode.removeFromParent()
        gridNode = .init(gridSize: world.size, realSize: realSize)
        configureNode()

        let previousElements = elements
        elements.removeAll()
        previousElements.forEach { element in
            let position = self.position(of: element)
            element.removeFromParent()
            placeElement(element, at: position)
        }

        children.forEach { child in
            guard child is EmissionNode else { return }
            child.removeFromParent()
        }
    }

    // MARK: - Level Loading
    func loadLevel(_ level: Level) {
        level.allElements.forEach { element in
            self.placeElement(element.generateNode(), at: element.position)
        }
    }

    // MARK: - Game Updates
    func onTick(tickCount: Int) {
        elements.forEach { $0.onTick(tickCount: tickCount) }
    }

    // MARK: - Element Placement
    private func placeElement(_ element: GridNode, at position: GridPosition) {
        addChild(element)
        element.position = realPosition(for: position)
        element.sizePerGrid = sizePerGrid
        element.gridWorld = self
        elements.append(element)
    }

    // MARK: - Helper Methods
    private func realPosition(for gridPosition: GridPosition) -> CGPoint {
        return .init(
            x: realSize.width * CGFloat(gridPosition.xIndex) / CGFloat(world.size.width) - sizePerGrid.width / 2,
            y: realSize.height * CGFloat(gridPosition.yIndex) / CGFloat(world.size.height) - sizePerGrid.height / 2
        )
    }
}

extension GridWorldNode: GridWorldReference {
    func emitQuantum(from emitterPosition: GridPosition, using direction: GridDirection) {
        let emission = EmissionNode()
        let realEmitterPosition = realPosition(for: emitterPosition)
        let realEmissionPosition: CGPoint = .init(x: realEmitterPosition.x + direction.vector.dx * 10, y: realEmitterPosition.y + direction.vector.dy * 10)
        emission.position = realEmissionPosition
        emission.sizePerGrid = sizePerGrid
        emission.gridWorld = self
        emission.setMovement(direction: direction)
        addChild(emission)
    }

    func position(of element: GridNode) -> GridPosition {
        return .init(xIndex: Int(ceil(element.position.x / sizePerGrid.width)), yIndex: Int(ceil(element.position.y / sizePerGrid.height)))
    }
}
