import UIKit

protocol PauseViewDelegate: AnyObject {
    func didSelectPlay()
    func didSelectAudio(isSoundEnabled: Bool)
}

final class PauseView: BlurBackgroundView {
    // MARK: - Subtypes
    private enum Constants {
        static let pausedString: String = "Game paused!"
        static let playString: String = "Continue"
        static let soundOffIconName: String = "speaker.slash.fill"
        static let soundOnIconName: String = "speaker.wave.2.fill"
    }

    // MARK: - Properties
    weak var delegate: MenuViewDelegate?

    // MARK: - Subviews
    private let imageView: UIImageView = .init(image: UIImage(named: "Images/Playground/QuantumControl-Logo.png"))
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
        self.delegate?.didSelectPlay()
    }

    private lazy var toggleAudioButton = BlurButton(icon: AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName) { [weak self] in
        guard let self = self else { return }
        self.didSelectAudioButton()
    }

    // MARK: - Initialization
    init(delegate: MenuViewDelegate) {
        self.delegate = delegate
        super.init()
        configureView()
    }

    // MARK: Configuration
    private func configureView() {
        configureImageView()
        configureStackView()
    }

    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func configureTitleLabel() {
        titleLabel.text = Constants.pausedString
        titleLabel.font = .systemFont(ofSize: 60, weight: .bold)
        titleLabel.textAlignment = .center

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    // MARK: - Actions
    private func didSelectAudioButton() {
        AudioManager.shared.isMusicPlaying.toggle()
        delegate?.didSelectAudio(isSoundEnabled: AudioManager.shared.isMusicPlaying)
        toggleAudioButton.setIcon(AudioManager.shared.isMusicPlaying ? Constants.soundOnIconName : Constants.soundOffIconName)
    }
}
