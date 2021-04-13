import SpriteKit

class GridNode: SKNode {
    let size: GridSize = .init(width: 1, height: 1)
    let sizePerGrid: CGSize = .init(width: 50, height: 50)

    // MARK: - Initialization
    override init() {
        super.init()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Game Update Helper
    func onTick(tickCount: Int) {
        // Override in subclass to execute action on game tick.
    }
}


