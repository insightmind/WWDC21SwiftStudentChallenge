import UIKit

final class LevelNameView: UIView {
    // MARK: - Subviews
    private let titleLabel: UILabel = .init()

    // MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        configureView()
        titleLabel.text = title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureView() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        titleLabel.font = .systemFont(ofSize: 60, weight: .bold)
        titleLabel.textColor = .white
    }
}
