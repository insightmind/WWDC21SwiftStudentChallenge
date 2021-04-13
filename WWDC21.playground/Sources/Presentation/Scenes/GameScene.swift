import SpriteKit

class GameScene: FlowableScene {
    private lazy var thirdRope: RopeNode = .init(startAnchor: .init(x: self.size.width / 2, y: self.size.height / 2), size: self.size)

    private lazy var anchorNode: CircleAnchor = .init(position: .zero)

    override func configureScene() {
        super.configureScene()

        addChild(thirdRope)
        thirdRope.keyColor = .crayola

        addChild(anchorNode)
        anchorNode.position = thirdRope.position.add(.init(x: 100 + self.size.width / 2, y: 50 + self.size.height / 2))
    }

    func touchDown(atPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos)
    }

    func touchMoved(toPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos)
    }

    func touchUp(atPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
