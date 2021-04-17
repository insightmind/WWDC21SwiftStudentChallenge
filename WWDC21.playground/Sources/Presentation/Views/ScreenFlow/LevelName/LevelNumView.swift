import SwiftUI

struct LevelNameView: View {
    @Binding var level: String
    @Binding var gameState: GameState

    var body: some View {
        Group {
            Text(level)
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
        }
        .animation(.easeInOut)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                withAnimation {
                    gameState = .game
                }
            }
        }
    }
}
