import UIKit

final class LevelNameView: BlurBackgroundView {
    // MARK: - Subviews
    private let titleLabel: UILabel = .init()

    // MARK: - Initialization
    init(title: String) {
        super.init()
        configureView()
        titleLabel.text = title
    }

    // MARK: Configuration
    private func configureView() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        titleLabel.font = .systemFont(ofSize: 60, weight: .bold)
        titleLabel.textColor = .white
    }
}
