import Foundation

protocol EmissionInteractor: GridNode {
    func handle(_ emission: EmissionNode)
}
