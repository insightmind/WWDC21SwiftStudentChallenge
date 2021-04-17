import Foundation
import AVFoundation

final class AudioManager {
    // MARK: - Public Properties
    static let shared: AudioManager = .init()

    // MARK: - Private Properties
    private var audioPlayer: AVAudioPlayer?

    var isMusicPlaying: Bool = true {
        didSet { isMusicPlaying ? startBackgroundMusic() : stopBackgroundMusic() }
    }

    private init() { /* Nothing to initialize */ }

    private func startBackgroundMusic() {
        guard !(audioPlayer?.isPlaying ?? false) else { return }
        guard let url = Bundle.main.url(forResource: Sound.backgroundMusic.fileName, withExtension: FileExtension.mp3.rawValue) else { return }
        guard let audioPlayer = try? AVAudioPlayer(contentsOf: url) else { return }

        self.audioPlayer = audioPlayer
        self.audioPlayer?.numberOfLoops = -1
        self.audioPlayer?.play()

        isMusicPlaying = true
    }

    private func stopBackgroundMusic() {
        guard audioPlayer?.isPlaying ?? false else { return }
        audioPlayer?.stop()
        isMusicPlaying = false
    }
}
