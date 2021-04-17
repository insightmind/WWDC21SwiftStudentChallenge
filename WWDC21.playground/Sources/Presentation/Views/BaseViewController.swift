import UIKit
import SpriteKit

public class BaseViewController: UIViewController {
    // MARK: - Properties
    private let viewSize: CGSize = CGSize(width: 750, height: 750)
    private lazy var scene: SimulationScene = .init(size: viewSize, level: .debug2)

    // MARK: - Subviews
    private let spriteKitView: SKView = .init()

    // MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }

    // MARK: - Configuration
    private func configureController() {
        view.frame = .init(origin: .zero, size: viewSize)
        configureSpriteKitView()
    }

    private func configureSpriteKitView() {
        spriteKitView.presentScene(scene)
        view.addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false

        spriteKitView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        spriteKitView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        spriteKitView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spriteKitView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scene.onCompletion = { [weak self] level in
            self?.didCompleteLevel(level: level)
        }
    }

    private func didCompleteLevel(level: AvailableLevels) {
        scene = SimulationScene(size: viewSize, level: level.next)
        scene.onCompletion = { [weak self] level in
            self?.didCompleteLevel(level: level)
        }

        spriteKitView.presentScene(scene, transition: .crossFade(withDuration: 0.3))
    }
}

