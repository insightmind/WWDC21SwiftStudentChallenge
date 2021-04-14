import SpriteKit

extension SKPhysicsBody {
    static func createEmissionInteractorBody(sizePerGrid: CGSize, position: CGPoint) -> SKPhysicsBody {
        let height = sizePerGrid.height / 3
        let width = sizePerGrid.width / 3

        let topLeft = CGPoint(x: position.x - width / 2, y: position.y + height)
        let topRight = CGPoint(x: position.x + width / 2, y: position.y + height)
        let leftTop = CGPoint(x: position.x - width, y: position.y + height / 2)
        let leftBottom = CGPoint(x: position.x - width, y: position.y - height / 2)
        let bottomLeft = CGPoint(x: position.x - width / 2, y: position.y - height)
        let bottomRight = CGPoint(x: position.x + width / 2, y: position.y - height)
        let rightTop = CGPoint(x: position.x + width, y: position.y + height / 2)
        let rightBottom = CGPoint(x: position.x + width, y: position.y - height / 2)

        let path = CGMutablePath()
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: rightTop)
        path.addLine(to: rightBottom)
        path.addLine(to: bottomRight)
        path.addLine(to: bottomLeft)
        path.addLine(to: leftBottom)
        path.addLine(to: leftTop)
        path.closeSubpath()

        return .init(polygonFrom: path)
    }

    func setMoveDirection(direction: GridDirection, velocityFactor: CGPoint) {
        collisionBitMask = ~(0b0 | direction.moveBitMask) & 0b1111_1111
        contactTestBitMask = direction.moveBitMask
        velocity = .init(dx: direction.vector.dx * velocityFactor.x, dy: direction.vector.dy * velocityFactor.y)
        categoryBitMask = 0b1_0000_0000
    }

    func receiveEmissions(from directions: [GridDirection]) {
        categoryBitMask = interactorCategory(interactionDirection: directions)
    }

    private func interactorCategory(interactionDirection directions: [GridDirection]) -> UInt32 {
        var bitmask: UInt32 = 0b0
        for direction in directions { bitmask |= direction.receiveBitMask }
        return bitmask
    }
}
