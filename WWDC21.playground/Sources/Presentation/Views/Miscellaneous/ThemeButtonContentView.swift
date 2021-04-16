import SwiftUI

struct ThemeButtonContentView: View {
    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 25, weight: .bold))
            .frame(width: 35, height: 35)
            .padding(8)
            .background(
                BlurView(style: .systemUltraThinMaterialDark)
                    .mask(RoundedRectangle(cornerRadius: 20))
            )
            .foregroundColor(.white)
    }
}

