import UIKit

final class BlurLabelButton: UIView {
    // MARK: - Properties
    private let font = UIFont.systemFont(ofSize: 30, weight: .bold)
    var onAction: () -> Void

    // MARK: - Subviews
    private let blurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let titleLabel: UILabel = .init()

    // MARK: - Initialization
    init(name: String, onAction: @escaping () -> Void) {
        self.onAction = onAction
        super.init(frame: .zero)
        titleLabel.text = name
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureView() {
        configureBlurView()
        configureIconView()
    }

    private func configureBlurView() {
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        blurView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        blurView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 51).isActive = true

        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
    }

    private func configureIconView() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = font

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    // MARK: - Public Methods
    func setText(_ string: String) {
        titleLabel.text = string
    }

    // MARK: - Interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        onAction()
    }
}
