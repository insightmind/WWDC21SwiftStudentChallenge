import SpriteKit

class GameScene: FlowableScene {
    override func configureScene() {
        super.configureScene()

        // TODO: Implement this
    }

    func touchDown(atPoint pos : CGPoint) {
        // TODO: Implement this
    }

    func touchMoved(toPoint pos : CGPoint) {
        // TODO: Implement this
    }

    func touchUp(atPoint pos : CGPoint) {
        // TODO: Implement this
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
