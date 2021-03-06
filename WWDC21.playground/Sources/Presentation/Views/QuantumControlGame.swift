import Foundation
import SpriteKit
import PlaygroundSupport

public class QuantumControlGame: PlaygroundLiveViewable {
    // MARK: - Public Properties
    public var playgroundLiveViewRepresentation: PlaygroundLiveViewRepresentation {
        return .view(view)
    }

    /// Use this view to present the game.
    private lazy var view: BaseGameView = BaseGameView()

    public init() {
        AudioManager.shared.isMusicPlaying = true
    }
}
