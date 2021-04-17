import SwiftUI

struct ThemeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .animation(.spring())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
