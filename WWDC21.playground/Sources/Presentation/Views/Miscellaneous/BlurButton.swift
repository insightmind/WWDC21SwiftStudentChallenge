import UIKit

final class BlurButton: UIView {
    // MARK: - Properties
    var onAction: () -> Void

    // MARK: - Subviews
    private let blurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    private let iconView: UIImageView = .init()

    // MARK: - Initialization
    init(icon: String, onAction: @escaping () -> Void) {
        self.onAction = onAction
        super.init(frame: .zero)

        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        iconView.image = UIImage(systemName: icon, withConfiguration: configuration)?.withTintColor(.white)
        iconView.tintColor = .white

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
        blurView.widthAnchor.constraint(equalTo: blurView.heightAnchor).isActive = true

        blurView.layer.cornerRadius = 15
        blurView.clipsToBounds = true
    }

    private func configureIconView() {
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false

        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
    }

    // MARK: - Public Methods
    func setIcon(_ icon: String) {
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        iconView.image = UIImage(systemName: icon, withConfiguration: configuration)?.withTintColor(.white)
        iconView.tintColor = .white
    }

    // MARK: - Interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        onAction()
    }
}
