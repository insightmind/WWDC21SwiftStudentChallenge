import SwiftUI
import SpriteKit

struct GameView: View {
    let viewSize: CGSize

    @Binding var level: AvailableLevels
    @Binding var isPaused: Bool
    @Binding var isSoundEnabled: Bool
    @Binding var gameState: GameState
    @Binding var levelName: String

    var body: some View {
        ZStack {
            //SpriteGameView(viewSize: viewSize, level: $level, levelName: $levelName, isPaused: $isPaused, isSoundEnabled: $isSoundEnabled)
                //.frame(width: viewSize.width, height: viewSize.height)
                //.ignoresSafeArea()

            InGameOverlayView(isPaused: $isPaused, isSoundEnabled: $isSoundEnabled) {
                // level = level
                levelName = level.name
            }
        }
        .scaleEffect(gameState != .game ? 0.9 : 1.0)

        // .onChange(of: isPaused) { scene.isPaused = $0 }
        // .onChange(of: isSoundEnabled) { scene.isMuted = !$0 }
    }

    private func didCompleteLevel(_ level: AvailableLevels) {
        //scene.level = level.next
        levelName = level.next.name
    }
}
