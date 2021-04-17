import UIKit

class BlurBackgroundView: UIView {
    // MARK: - Style
    var effect: UIVisualEffect? {
        get { blurView.effect }
        set { blurView.effect = newValue }
    }

    // MARK: - Subviews
    private let blurView: UIVisualEffectView = .init()
    var contentView: UIView = .init()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureBlurView()
        configureContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureBlurView() {
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        blurView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        blurView.effect = nil
    }

    private func configureContentView() {
        contentView.backgroundColor = .clear

        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
