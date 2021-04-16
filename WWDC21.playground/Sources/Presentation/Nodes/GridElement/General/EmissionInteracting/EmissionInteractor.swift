import SpriteKit

protocol EmissionInteractor: SKNode {
    func handle(_ emission: EmissionNode)
}
