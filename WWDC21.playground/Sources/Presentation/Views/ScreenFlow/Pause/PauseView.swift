import UIKit

protocol PauseViewDelegate: AnyObject {
    func didSelectContinue()
    func didSelectAudio(isSoundEnabled: Bool)
}

final class PauseView: UIView {
    // MARK: - Subtypes
    private enum Constants {
        static let pausedString: String = "Game paused!"
        static let playString: String = "Continue"
        static let soundOffIconName: String = "speaker.slash.fill"
        static let soundOnIconName: String = "speaker.wave.2.fill"
    }

    // MARK: - Properties
    weak var delegate: PauseViewDelegate?

    // MARK: - Subviews
    private let titleLabel: UILabel = .init()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [pauseButton, toggleAudioButton])
        view.spacing = 8
        view.distribution = .fillProportionally
        view.axis = .horizontal
        return view
    }()

    private lazy var pauseButton = BlurLabelButton(name: Constants.playString) { [weak self] in
        guard let self = self else { return }
        self.delegate?.didSelectContinue()
    }

    private lazy var toggleAudioButton = BlurButton(icon: AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName) { [weak self] in
        guard let self = self else { return }
        self.didSelectAudioButton()
    }

    // MARK: - Initialization
    init(delegate: PauseViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureView() {
        configureTitleLabel()
        configureStackView()
    }

    private func configureTitleLabel() {
        titleLabel.text = Constants.pausedString
        titleLabel.font = .systemFont(ofSize: 60, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    // MARK: - Actions
    private func didSelectAudioButton() {
        AudioManager.shared.isMusicPlaying.toggle()
        delegate?.didSelectAudio(isSoundEnabled: AudioManager.shared.isMusicPlaying)
        toggleAudioButton.setIcon(AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName)
    }
}
