import SpriteKit

final class GridWorldNode: SKNode, GridPlacementReference {
    // MARK: - Properties
    weak var delegate: GridWorldDelegate?
    var realSize: CGSize { .init(width: CGFloat(level.world.size.width) * sizePerGrid.width, height: sizePerGrid.height * CGFloat(level.world.size.height)) }
    var sizePerGrid: CGSize = .init(width: 30, height: 30) {
        didSet { layoutWorld() }
    }

    var isMuted: Bool = true {
        didSet { didUpdateMuteSettings() }
    }

    // MARK: - Private Properties
    private var level: Level = .init()
    private var enabledGroups: Set<GridInteractionGroup> = [] {
        didSet {
            guard oldValue != enabledGroups else { return }
            didUpdateEnabledGroups()
        }
    }

    // MARK: - Children
    private var elements: [GridNode] = []
    private lazy var gridNode: GridShapeNode = .init(gridSize: level.world.size, realSize: realSize)

    // MARK: - Initialization
    init(sizePerGrid: CGSize) {
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
        gridNode = .init(gridSize: level.world.size, realSize: realSize)
        configureNode()

        let previousElements = elements
        elements.removeAll()
        previousElements.forEach { element in
            let position = self.position(of: element)
            element.removeFromParent()
            element.position = realPosition(for: position)
            placeElement(element)
        }

        children.forEach { child in
            guard child is EmissionNode else { return }
            child.removeFromParent()
        }
    }

    // MARK: - Level Loading
    func loadLevel(_ level: Level) {
        layoutWorld()

        self.level = level
        enabledGroups = []
        level.allElements.forEach { element in
            self.placeElement(element.generatePlaceableNode(using: self))
        }

        didUpdateMuteSettings()
    }

    // MARK: - Game Updates
    func onTick(tickCount: Int) {
        elements.forEach { $0.onTick(tickCount: tickCount) }
    }

    // MARK: - Element Placement
    private func placeElement(_ element: GridNode) {
        addChild(element)
        element.sizePerGrid = sizePerGrid
        element.gridWorld = self
        elements.append(element)
    }

    // MARK: - Helper Methods
    func realPosition(for gridPosition: GridPosition) -> CGPoint {
        return .init(
            x: realSize.width * CGFloat(gridPosition.xIndex) / CGFloat(level.world.size.width) - sizePerGrid.width / 2,
            y: realSize.height * CGFloat(gridPosition.yIndex) / CGFloat(level.world.size.height) - sizePerGrid.height / 2
        )
    }

    private func didUpdateEnabledGroups() {
        if enabledGroups == level.groupsToFulfill {
            delegate?.didFinishLevel()
        }

        elements.forEach { element in
            guard let node = element as? GroupUpdatable else { return }
            node.onGroupUpdate(enabledGroups: enabledGroups)
        }
    }

    private func didUpdateMuteSettings() {
        elements.forEach { $0.isMuted = isMuted }
        print("Is muted: \(isMuted)")
    }
}

extension GridWorldNode: GridWorldReference {
    func emitQuantum(from position: CGPoint, using direction: GridDirection, group: GridInteractionGroup) {
        let emission = EmissionNode(group: group)
        let realEmissionPosition: CGPoint = .init(x: position.x + direction.vector.dx * 10, y: position.y + direction.vector.dy * 10)
        emission.position = realEmissionPosition
        emission.sizePerGrid = sizePerGrid
        emission.gridWorld = self
        emission.setMovement(direction: direction)
        addChild(emission)
    }

    func position(of element: GridNode) -> GridPosition {
        return .init(xIndex: Int(ceil(element.position.x / sizePerGrid.width)), yIndex: Int(ceil(element.position.y / sizePerGrid.height)))
    }

    func setGroup(_ group: GridInteractionGroup, isEnabled: Bool) {
        if isEnabled {
            enabledGroups.insert(group)
        } else {
            enabledGroups.remove(group)
        }
    }
}
