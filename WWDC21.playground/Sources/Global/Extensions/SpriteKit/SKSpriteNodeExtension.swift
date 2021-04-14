import SpriteKit

extension SKSpriteNode {
    var isLigthningEnabled: Bool {
        set {
            lightingBitMask = newValue ? 0b1 : 0b0
            shadowCastBitMask = lightingBitMask
            shadowedBitMask = lightingBitMask
        }

        get {
            lightingBitMask == 0b1
        }
    }
}
