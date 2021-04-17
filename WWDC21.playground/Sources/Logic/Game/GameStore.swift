import Foundation

class GameStore: ObservableObject {
    @Published var isSoundEnabled: Bool = false
    @Published var isPaused: Bool = false {
        didSet { gameState = isPaused ? .pause : .game }
    }

    @Published var gameState: GameState = .menu
    @Published var levelName: String = "" {
        didSet { gameState = .levelName }
    }
}
