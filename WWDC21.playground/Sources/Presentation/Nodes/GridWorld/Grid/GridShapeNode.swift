import SpriteKit

final class GridShapeNode: SKNode, EmissionInteractor {
    // MARK: - Subtypes
    private enum Constants {
        static let cornerNodeName: String = "Images/World/PlayareaBorder-Corner"
        static let sideNodeName: String = "Images/World/PlayareaBorder-Side"
    }

    // MARK: - Properties
    private let gridSize: GridSize
    private let realSize: CGSize
    private let tintColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    private let lineWidth: CGFloat = 4
    private var sizePerGrid: CGSize { .init(width: realSize.width / CGFloat(gridSize.width), height: realSize.height / CGFloat(gridSize.height)) }

    // MARK: - Subnodes
    private var backgroundNode: SKShapeNode = .init()

    // MARK: - Initialization
    init(gridSize: GridSize, realSize: CGSize) {
        self.gridSize = gridSize
        self.realSize = realSize

        super.init()

        layoutNode()
        isUserInteractionEnabled = false
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func layoutNode() {
        children.forEach { $0.removeFromParent() }
        backgroundNode.removeFromParent()

        drawBackgroundNode()

        // drawVerticalLines()
        // drawHorizontalLines()

        drawCornerNodes()
        drawSideNodes()

        configurePhysicsBody()
    }

    private func configurePhysicsBody() {
        physicsBody = .init(edgeLoopFrom: .init(origin: .zero, size: realSize))
        physicsBody?.receiveEmissions(from: GridDirection.allCases)
    }

    // MARK: - Draw Background Node
    private func drawBackgroundNode() {
        backgroundNode = .init(rectOf: realSize)
        backgroundNode.fillColor = .darkPurple
        backgroundNode.position = .init(x: realSize.width / 2, y: realSize.height / 2)
        addChild(backgroundNode)
    }

    // MARK: - Draw Border
    private func drawCornerNodes() {
        // We create a corner node for each of our corners (4 total)
        for index in 0 ..< 4 {
            let node = SKSpriteNode(imageNamed: Constants.cornerNodeName)
            node.size = sizePerGrid
            node.anchorPoint = .init(x: 0.5, y: 0.5)
            node.zRotation = CGFloat(index) * .pi / 2

            let xPosition = index < 2 ? -sizePerGrid.width / 2 : realSize.width + sizePerGrid.width / 2
            let yPosition = index > 0 && index < 3 ? -sizePerGrid.height / 2 : realSize.height + sizePerGrid.height / 2

            node.position = .init(x: xPosition, y: yPosition)
            addChild(node)
        }
    }

    private func drawSideNodes() {
        let topRightPosition = CGPoint(x: realSize.width + sizePerGrid.width / 2, y: realSize.height + sizePerGrid.height / 2)
        let bottomLeftPosition = CGPoint(x: -sizePerGrid.width / 2, y: -sizePerGrid.height / 2)

        for index in 1 ... gridSize.width {
            let topNode = SKSpriteNode(imageNamed: Constants.sideNodeName)
            topNode.size = sizePerGrid
            topNode.anchorPoint = .init(x: 0.5, y: 0.5)
            topNode.zRotation = -.pi / 2
            topNode.position = .init(x: bottomLeftPosition.x + sizePerGrid.width * CGFloat(index), y: topRightPosition.y)

            addChild(topNode)

            let bottomNode = SKSpriteNode(imageNamed: Constants.sideNodeName)
            bottomNode.size = sizePerGrid
            bottomNode.anchorPoint = .init(x: 0.5, y: 0.5)
            bottomNode.zRotation = .pi / 2
            bottomNode.position = .init(x: bottomLeftPosition.x + sizePerGrid.width * CGFloat(index), y: bottomLeftPosition.y)

            addChild(bottomNode)
        }

        for index in 1 ... gridSize.height {
            let leftNode = SKSpriteNode(imageNamed: Constants.sideNodeName)
            leftNode.size = sizePerGrid
            leftNode.anchorPoint = .init(x: 0.5, y: 0.5)
            leftNode.position = .init(x: bottomLeftPosition.x, y: bottomLeftPosition.y + sizePerGrid.height * CGFloat(index))

            addChild(leftNode)

            let rightNode = SKSpriteNode(imageNamed: Constants.sideNodeName)
            rightNode.size = sizePerGrid
            rightNode.anchorPoint = .init(x: 0.5, y: 0.5)
            rightNode.zRotation = .pi
            rightNode.position = .init(x: topRightPosition.x, y: bottomLeftPosition.y + sizePerGrid.height * CGFloat(index))

            addChild(rightNode)
        }
    }

    // MARK: - Draw Grid
    private func drawVerticalLines() {
        let verticalOffset = sizePerGrid.height

        for index in 0...gridSize.height {
            let path = CGMutablePath()
            let yPosition = CGFloat(index) * verticalOffset
            path.move(to: .init(x: 0, y: yPosition))
            path.addLine(to: .init(x: realSize.width, y: yPosition))

            let lineNode = SKShapeNode(path: path)
            lineNode.strokeColor = tintColor
            lineNode.lineWidth = lineWidth
            lineNode.alpha = tintColor.cgColor.alpha

            addChild(lineNode)
        }
    }

    private func drawHorizontalLines() {
        let horizontalOffset = sizePerGrid.width

        for index in 0...gridSize.width {
            let path = CGMutablePath()
            let xPosition = CGFloat(index) * horizontalOffset
            path.move(to: .init(x: xPosition, y: 0))
            path.addLine(to: .init(x: xPosition, y: realSize.height))

            let lineNode = SKShapeNode(path: path)
            lineNode.strokeColor = tintColor
            lineNode.lineWidth = lineWidth
            lineNode.alpha = tintColor.cgColor.alpha

            addChild(lineNode)
        }
    }

    // MARK: - Emission Handling
    func handle(_ emission: EmissionNode) {
        emission.removeFromParent()
    }
}
