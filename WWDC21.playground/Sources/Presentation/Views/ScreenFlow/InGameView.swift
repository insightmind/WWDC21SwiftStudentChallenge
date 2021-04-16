import SwiftUI

struct InGameView: View {
    @Binding var isPaused: Bool
    @Binding var isSoundEnabled: Bool

    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 8) {
                    Button {
                        withAnimation(.spring()) {
                            isPaused.toggle()
                        }
                    } label : {
                        ThemeButtonContentView(iconName: "pause.fill")
                    }

                    Button {
                        withAnimation(.spring()) {
                            print("Reset")
                        }
                    } label : {
                        ThemeButtonContentView(iconName: "arrow.clockwise")
                    }

                    Button {
                        withAnimation(.spring()) {
                            isSoundEnabled.toggle()
                        }
                    } label : {
                        ThemeButtonContentView(iconName: isSoundEnabled ? "speaker.fill" : "speaker.slash.fill")
                    }

                    Spacer()
                }
                .frame(height: 50)

                Spacer()
            }
            .padding(20)
        }
    }
}
