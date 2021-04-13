import SpriteKit

class GameScene: FlowableScene {
    private lazy var thirdRope: RopeNode = .init(startAnchor: .init(x: 0, y: self.size.height / 2), size: self.size)

    private lazy var firstAnchor: CircleAnchor = .init(position: .zero)
    private lazy var secondAnchor: CircleAnchor = .init(position: .zero)

    private var anchors: [CircleAnchor] = []

    override func configureScene() {
        super.configureScene()

        addChild(thirdRope)
        thirdRope.keyColor = .charcoal

        addChild(firstAnchor)
        firstAnchor.position = .init(x: self.size.width * 0.5, y: self.size.height * 0.75)
        anchors.append(firstAnchor)

        addChild(secondAnchor)
        secondAnchor.position = .init(x: self.size.width * 0.5, y: self.size.height * 0.25)
        anchors.append(secondAnchor)
    }

    func touchDown(atPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos, anchors: anchors)
    }

    func touchMoved(toPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos, anchors: anchors)
    }

    func touchUp(atPoint pos : CGPoint) {
        thirdRope.updateEndPoint(pos, anchors: anchors)
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
