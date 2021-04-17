import SwiftUI

struct PauseView: View {
    private enum Constants {
        static let playIconName: String = "play.fill"
    }

    @Binding var isPaused: Bool

    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "Images/Playground/QuantumControl-Logo.png")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400)
                .transition(.opacity)

            Button {
                withAnimation {
                    isPaused = false
                }
            } label : {
                ThemeButtonContentView(iconName: Constants.playIconName, dynamicWidth: false)
            }
        }
    }
}
