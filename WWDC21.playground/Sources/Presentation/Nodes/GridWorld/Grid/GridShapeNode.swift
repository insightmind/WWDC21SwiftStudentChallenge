import SpriteKit

final class GridShapeNode: SKNode {
    // MARK: - Properties
    private let gridSize: GridSize
    private let realSize: CGSize
    private let tintColor: UIColor = .russianViolet
    private let lineWidth: CGFloat = 2

    private var verticalShapeNodes: [SKShapeNode] = .init()
    private var horizontalShapeNodes: [SKShapeNode] = .init()

    // MARK: - Initialization
    init(gridSize: GridSize, realSize: CGSize) {
        self.gridSize = gridSize
        self.realSize = realSize

        super.init()

        configureNode()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureNode() {
        drawVerticalLines()
        drawHorizontalLines()
    }

    private func drawVerticalLines() {
        let verticalOffset = realSize.height / CGFloat(gridSize.height)

        for index in 0...gridSize.height {
            let path = CGMutablePath()
            let yPosition = CGFloat(index) * verticalOffset
            path.move(to: .init(x: 0, y: yPosition))
            path.addLine(to: .init(x: realSize.width, y: yPosition))

            let lineNode = SKShapeNode(path: path)
            lineNode.strokeColor = tintColor
            lineNode.lineWidth = lineWidth

            verticalShapeNodes.append(lineNode)
            addChild(lineNode)
        }
    }

    private func drawHorizontalLines() {
        let horizontalOffset = realSize.width / CGFloat(gridSize.width)

        for index in 0...gridSize.width {
            let path = CGMutablePath()
            let xPosition = CGFloat(index) * horizontalOffset
            path.move(to: .init(x: xPosition, y: 0))
            path.addLine(to: .init(x: xPosition, y: realSize.height))

            let lineNode = SKShapeNode(path: path)
            lineNode.strokeColor = tintColor
            lineNode.lineWidth = lineWidth

            verticalShapeNodes.append(lineNode)
            addChild(lineNode)
        }
    }
}
