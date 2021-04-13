// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

/*
 * A FlowableScene encapsulates properties to allow dynamic transitioning and
 * organization of SpriteKitScenes. More specfically it allows a SKScene to
 * be dynamically configured by the Game Coordinator.
 */
open class FlowableScene: SKScene {
    /// Creates a new FlowableScene with the required parameters.
    /// - Parameters:
    ///   - size: The size of the scene
    ///   - flowDelegate: The delegate to allow dynamic transition between scenes
    ///   - model: The view model of this scene
    required override public init(size: CGSize) {
        super.init(size: size)
        configureScene()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard Scene Loading is unsupported")
    }

    /**
     * Implement this method in a subclass to configure the scene, such as adding child nodes etc.
     */
    open func configureScene() {
        isUserInteractionEnabled = true
        backgroundColor = .darkPurple

        // Implement this in subclass
    }
}
