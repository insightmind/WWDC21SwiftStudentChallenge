import SpriteKit

final class RotatingEmitterNode: EmitterNode {
    enum Constants {
        static let leftRotateImageName: String = "Images/Nodes/Emitter/Emitter_rotate_left"
        static let rightRotateImageName: String = "Images/Nodes/Emitter/Emitter_rotate_right"
    }

    // MARK: - Properties
    var rotatesToLeft: Bool = false {
        didSet { reconfigureNode() }
    }

    // MARK: - Childnodes
    private let spriteNode: SKSpriteNode = .init(imageNamed: Constants.leftRotateImageName)

    // MARK: - Initialization
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Configuration
    private func configureNode() {
        addChild(spriteNode)
        spriteNode.size = sizePerGrid
    }

    private func reconfigureNode() {
        spriteNode.texture = .init(imageNamed: rotatesToLeft ? Constants.leftRotateImageName : Constants.rightRotateImageName)
    }

    override func layoutNode() {
        spriteNode.size = sizePerGrid
    }

    // MARK: - Game Update
    override func onTick(tickCount: Int) {
        guard tickCount % emitInterval == 0 else {
            super.onTick(tickCount: tickCount)
            return
        }

        let delayAction = SKAction.wait(forDuration: 0.4)
        let action = SKAction.rotate(byAngle: rotatesToLeft ? -.pi / 2 : .pi / 2, duration: 0.5)
        let sequence = SKAction.sequence([delayAction, action])

        spriteNode.run(sequence)

        switch emitDirection {
        case .left:
            emitDirection = rotatesToLeft ? .down : .up

        case .up:
            emitDirection = rotatesToLeft ? .left : .right

        case .right:
            emitDirection = rotatesToLeft ? .up : .down

        case .down:
            emitDirection = rotatesToLeft ? .right : .left
        }

        super.onTick(tickCount: tickCount)
    }
}
