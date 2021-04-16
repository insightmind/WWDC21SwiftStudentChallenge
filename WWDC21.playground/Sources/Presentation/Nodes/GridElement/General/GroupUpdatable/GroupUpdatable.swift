import Foundation

protocol GroupUpdatable: GridNode {
    func onGroupUpdate(enabledGroups: Set<GridInteractionGroup>)
}
