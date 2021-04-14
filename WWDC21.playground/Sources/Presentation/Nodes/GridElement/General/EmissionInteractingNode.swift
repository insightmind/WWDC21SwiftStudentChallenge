import SpriteKit

class EmissionInteractingNode: GridNode {
    // MARK: - Properties
    var emitDirections: Set<GridDirection> = []
    var receiveDirections: Set<GridDirection> = [] {
        didSet { reloadPhysicsShape() }
    }

    // MARK: Emission Interaction Implementations
    func handle(_ emission: EmissionNode) {
        absorb(emission: emission)
        emit()
    }

    func absorb(emission: EmissionNode) {
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.05)
        let removeAction = SKAction.removeFromParent()
        emission.run(.sequence([fadeAction, removeAction]))
    }

    func emit() {
        guard !emitDirections.isEmpty, let position = gridWorld?.position(of: self) else { return }
        animateEmitter()

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) { [weak self] in
            guard let self = self else { return }
            self.emitDirections.forEach { self.gridWorld?.emitQuantum(from: position, using: $0) }
        }
    }

    // MARK: - Node layout
    override func layoutNode() {
        reloadPhysicsShape()
    }

    // MARK: - Animations
    private func animateEmitter() {
        let scaleDown = SKAction.scale(by: 0.95, duration: 0.3)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.1)
        let scaleReturn = SKAction.scale(to: 1, duration: 0.1)

        let sequence = SKAction.sequence([scaleDown, scaleUp, scaleReturn])

        self.run(sequence)
    }

    // MARK: - PhysicsShape loading
    private func reloadPhysicsShape() {
        physicsBody = .createEmissionInteractorBody(sizePerGrid: sizePerGrid, position: position)
        physicsBody?.isDynamic = false
        physicsBody?.receiveEmissions(from: .init(receiveDirections))
    }
}
