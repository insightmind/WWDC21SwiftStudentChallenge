import UIKit

protocol InGameViewDelegate: AnyObject {
    func didSelectPause()
    func didSelectReload()
    func didSelectAudio(isSoundEnabled: Bool)
}

final class InGameView: UIView {
    // MARK: - Subtypes
    private enum Constants {
            static let pauseIconName: String = "pause.fill"
            static let resetIconName: String = "arrow.clockwise"
            static let soundOffIconName: String = "speaker.slash.fill"
            static let soundOnIconName: String = "speaker.wave.2.fill"
        }

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

    private lazy var pauseButton = BlurButton(icon: Constants.pauseIconName) { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectPause()
    }

    private lazy var reloadButton = BlurButton(icon: Constants.resetIconName) { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectReload()
    }

    private lazy var toggleAudioButton = BlurButton(icon: AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName) { [weak self] in
        guard let self = self else { return }
        self.didSelectAudioButton()
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

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    // MARK: - Actions
    private func didSelectAudioButton() {
        AudioManager.shared.isMusicPlaying.toggle()
        delegate?.didSelectAudio(isSoundEnabled: AudioManager.shared.isMusicPlaying)
        toggleAudioButton.setIcon(AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName)
    }
}

