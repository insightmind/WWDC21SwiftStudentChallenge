// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

class RopeSegmentNode {
    // MARK: - Properties
    var endPoint: CGPoint

    // MARK: - Initialization
    init() {
        self.endPoint = .zero
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Drawing
    func drawPath(path: CGMutablePath) -> CGMutablePath {
        // Override this in subclass
        fatalError("Override this in subclass")
    }
}
