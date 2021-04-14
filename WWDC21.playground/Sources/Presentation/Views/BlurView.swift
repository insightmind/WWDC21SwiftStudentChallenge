import UIKit

class BlurView: UIVisualEffectView {
    // MARK: - Initialization
    init() {
        super.init(effect: UIBlurEffect(style: .regular))
        layer.zPosition = 100
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
