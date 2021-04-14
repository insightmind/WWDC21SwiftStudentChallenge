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
        guard tickCount % emitInterval == 0, let emitDirection = emitDirections.first else {
            super.onTick(tickCount: tickCount)
            return
        }

        switch emitDirection {
        case .left:
            emitDirections = [rotatesToLeft ? .down : .up]

        case .up:
            emitDirections = [rotatesToLeft ? .left : .right]

        case .right:
            emitDirections = [rotatesToLeft ? .up : .down]

        case .down:
            emitDirections = [rotatesToLeft ? .right : .left]

        default:
            break
        }

        let delayAction = SKAction.wait(forDuration: 0.4)
        let action = SKAction.rotate(toAngle: emitDirection.rotationInRadians, duration: 0.5, shortestUnitArc: true)
        let sequence = SKAction.sequence([delayAction, action])

        spriteNode.run(sequence)

        super.onTick(tickCount: tickCount)
    }
}
