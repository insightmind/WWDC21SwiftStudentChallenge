import SpriteKit

class GameScene: FlowableScene {
    private lazy var firstRope: RopeNode = .init(startAnchor: .init(x: 0.0, y: 0.3), size: self.size)
    private lazy var secondRope: RopeNode = .init(startAnchor: .init(x: 0.0, y: 0.4), size: self.size)
    private lazy var thirdRope: RopeNode = .init(startAnchor: .init(x: 0.0, y: 0.5), size: self.size)
    private lazy var fourthRope: RopeNode = .init(startAnchor: .init(x: 0.0, y: 0.6), size: self.size)
    private lazy var fifthRope: RopeNode = .init(startAnchor: .init(x: 0.0, y: 0.7), size: self.size)

    private lazy var anchorNode: CircleAnchor = .init(position: .zero)

    override func configureScene() {
        super.configureScene()
        addChild(firstRope)
        firstRope.keyColor = .charcoal
        addChild(secondRope)
        secondRope.keyColor = .persianGreen
        addChild(thirdRope)
        thirdRope.keyColor = .crayola
        addChild(fourthRope)
        fourthRope.keyColor = .sandyBrown
        addChild(fifthRope)
        fifthRope.keyColor = .burntSienna

        addChild(anchorNode)
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
