import SpriteKit

final class PlaygroundSpriteKitView: SKView {
    override func layoutSubviews() {
        super.layoutSubviews()
        scene?.size = frame.size
    }
}

