import UIKit

final class FinishView: UIView {
    // MARK: - Properties
    private let title: String = "Congratulations!"
    private let subtitle: String = "You've completed all levels!"

    // MARK: - Subviews
    private let titleLabel: UILabel = .init()
    private let subtitleLabel: UILabel = .init()

    // MARK: - Initialization
    init() {
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
        configureSubtitleLabel()
    }

    private func configureTitleLabel() {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 50, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func configureSubtitleLabel() {
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0

        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
