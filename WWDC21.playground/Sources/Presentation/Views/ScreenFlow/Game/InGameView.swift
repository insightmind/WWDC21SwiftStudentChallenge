import UIKit

protocol InGameViewDelegate: AnyObject {
    func didSelectPause()
    func didSelectReload()
    func didSelectAudio(isSoundEnabled: Bool)
}

final class InGameView: UIView {
    // MARK: - Properties
    weak var delegate: InGameViewDelegate?

    // MARK: - Subviews
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [pauseButton, reloadButton, toggleAudioButton])
        view.spacing = 8
        view.distribution = .fillEqually
        view.axis = .horizontal
        return view
    }()

    private lazy var pauseButton = BlurButton(icon: "pause.fill") { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectPause()
    }

    private lazy var reloadButton = BlurButton(icon: "arrow.clockwise") { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectReload()
    }

    private lazy var toggleAudioButton = BlurButton(icon: "pause.fill") { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectAudio(isSoundEnabled: .random())
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

