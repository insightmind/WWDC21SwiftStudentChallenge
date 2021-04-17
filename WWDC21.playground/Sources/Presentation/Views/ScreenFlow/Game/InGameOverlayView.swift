import SwiftUI

struct InGameOverlayView: View {
    private enum Constants {
        static let pauseIconName: String = "pause.fill"
        static let resetIconName: String = "arrow.clockwise"
        static let soundOffIconName: String = "speaker.slash.fill"
        static let soundOnIconName: String = "speaker.wave.2.fill"
    }

    @Binding var isPaused: Bool
    @Binding var isSoundEnabled: Bool
    let reloadLevel: () -> Void

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 8) {
                    Button {
                        withAnimation(.easeInOut) {
                            isPaused.toggle()
                        }
                    } label: {
                        ThemeButtonContentView(iconName: Constants.pauseIconName, dynamicWidth: false)
                    }
                    .buttonStyle(ThemeButtonStyle())

                    Button {
                        reloadLevel()
                    } label: {
                        ThemeButtonContentView(iconName:Constants.resetIconName, dynamicWidth: false)
                    }
                    .buttonStyle(ThemeButtonStyle())

                    Button {
                        isSoundEnabled.toggle()
                    } label: {
                        ThemeButtonContentView(iconName: isSoundEnabled ? Constants.soundOnIconName : Constants.soundOffIconName, dynamicWidth: false)
                    }
                    .buttonStyle(ThemeButtonStyle())

                    Spacer()
                }
                .frame(height: 50)

                Spacer()
            }
            .padding(20)
        }
    }
}
