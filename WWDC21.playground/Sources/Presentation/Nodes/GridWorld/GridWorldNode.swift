import SpriteKit

final class GridWorldNode: SKSpriteNode {
    // MARK: - Properties
    private let world: GridWorld

    // MARK: - Children
    private let elements: [GridNode] = []

    // MARK: - Initialization
    init(size: CGSize, world: GridWorld) {
        self.world = world
        super.init(texture: nil, color: .clear, size: size)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Game Updates
    func onTick(tickCount: Int) {
        // TODO: Implement this
    }
}
