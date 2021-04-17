import UIKit
import SpriteKit

public class BaseGameView: UIView {
    // MARK: - Properties
    private var gameState: GameState = .menu {
        didSet { didUpdateGameState() }
    }

    private let viewSize: CGSize = CGSize(width: 750, height: 750)
    private lazy var scene: SimulationScene = .init(size: viewSize, level: .level(index: 1))

    // MARK: - Subviews
    private let spriteKitView: SKView = .init()
    private let inGameView: InGameView = .init()
    private var blurView: BlurBackgroundView?

    // MARK: - LifeCycle
    override init(frame: CGRect = .init(origin: .zero, size: CGSize(width: 750, height: 750))) {
        super.init(frame: frame)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureView() {
        frame = .init(origin: .zero, size: CGSize(width: 750, height: 750))
        backgroundColor = .black

        configureSpriteKitView()
        configureIngameView()
        didUpdateGameState(animated: false)
    }

    private func configureSpriteKitView() {
        spriteKitView.presentScene(scene)
        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false

        spriteKitView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spriteKitView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        spriteKitView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spriteKitView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        scene.onCompletion = { [weak self] level in
            self?.didCompleteLevel(level: level)
        }
    }

    private func configureIngameView() {
        addSubview(inGameView)
        inGameView.translatesAutoresizingMaskIntoConstraints = false

        inGameView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        inGameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true

        inGameView.delegate = self
    }

    // MARK: - Animations
    private func transitionToHiddenGame(animated: Bool, blurView: BlurBackgroundView) {
        blurView.isHidden = false
        blurView.contentView.alpha = 0

        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false

        blurView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        self.blurView = blurView

        UIView.animate(withDuration: animated ? 0.7 : 0.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) {
            self.spriteKitView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.blurView?.effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            self.blurView?.contentView.alpha = 1.0
            self.inGameView.transform = CGAffineTransform(translationX: 0, y: -100)
        } completion: { _ in }
    }

    private func transitionToInteractableGame(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.7 : 0.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.spriteKitView.transform = .identity
            self.blurView?.effect = nil
            self.blurView?.contentView.alpha = 0.0
            self.inGameView.transform = .identity
        } completion: { _ in
            self.blurView?.isHidden = true
            self.blurView?.removeFromSuperview()
            self.blurView = nil
            self.spriteKitView.isPaused = false
        }
    }

    private func loadLevel(_ level: AvailableLevels) {
        scene = SimulationScene(size: viewSize, level: level)
        scene.onCompletion = { [weak self] level in
            self?.didCompleteLevel(level: level)
        }

        spriteKitView.presentScene(scene, transition: .crossFade(withDuration: 0.5))
    }

    // MARK: - Actions
    private func didUpdateGameState(animated: Bool = true) {
        switch gameState {
        case .game:
            scene.isPaused = false
            transitionToInteractableGame(animated: animated)

        case .menu:
            transitionToHiddenGame(animated: animated, blurView: MenuView(delegate: self))

        case .pause:
            scene.isPaused = true
            transitionToHiddenGame(animated: animated, blurView: PauseView(delegate: self))

        case .finish:
            transitionToHiddenGame(animated: animated, blurView: FinishView(title: "Finished all levels"))

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                self?.loadLevel(.level(index: 1))
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                self?.gameState = .menu
            }

        case let .levelName(level):
            transitionToHiddenGame(animated: animated, blurView: LevelNameView(title: level.name))

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                self?.loadLevel(level)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
                self?.gameState = .game
            }
        }
    }

    private func didCompleteLevel(level: AvailableLevels) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            if let next = level.next {
                self?.gameState = .levelName(level: next)
            } else {
                self?.gameState = .finish
            }

        }
    }
}

// MARK: - Delegates
extension BaseGameView: InGameViewDelegate, MenuViewDelegate {
    func didSelectPause() {
        gameState = .pause
    }

    func didSelectPlay() {
        gameState = .game
    }

    func didSelectReload() {
        gameState = .levelName(level: scene.level)
    }

    func didSelectAudio(isSoundEnabled: Bool) {
        scene.isMuted = !isSoundEnabled
    }
}

