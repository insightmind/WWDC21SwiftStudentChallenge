import SwiftUI
import SpriteKit

struct GameView: View {
    let viewSize: CGSize

    @ObservedObject var scene: SimulationScene
    @ObservedObject var gameStore: GameStore
    @Binding var gameState: GameState

    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: viewSize.width, height: viewSize.height)
                .ignoresSafeArea()
                .animation(.spring())

            InGameOverlayView(isPaused: $gameStore.isPaused, isSoundEnabled: $gameStore.isSoundEnabled) {
                scene.level = scene.level
                gameStore.levelName = scene.level.name
            }
        }
        .scaleEffect(gameState != .game ? 0.9 : 1.0)
    }
}
