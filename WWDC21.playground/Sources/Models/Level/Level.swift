import Foundation

struct Level: Codable {
    // World Information
    let world: GridWorld

    // Static World elements
    let emitter: [GridEmitter]
    let transmitter: [GridTransmitter]
    let receiver: [GridReceiver]

    // Interactable World elements
    let mirrors: [GridMirror]
}
