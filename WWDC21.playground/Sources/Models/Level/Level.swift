import Foundation

struct Level: Codable {
    // World Information
    let world: GridWorld

    // Static World elements
    let elements: [GridElementType]

    // MARK: Computed Elements
    var allElements: [GridElement] {
        return elements.map { type in
            switch type {
            case let .emitter(node):
                return node

            case let .transmitter(node):
                return node

            case let .receiver(node):
                return node

            case let .mirror(node):
                return node

            case let .wall(node):
                return node

            case let .groupWall(node):
                return node
            }
        }
    }

    var groupsToFulfill: Set<GridInteractionGroup> {
        let multiset = allElements.compactMap { $0 as? GridReceiver }.map(\.receiveGroup)
        return .init(multiset)
    }


    // MARK: - Initializer
    init(world: GridWorld = .init(), elements: [GridElement] = []) {
        self.world = world
        self.elements = elements.map(\.type)
    }
}
