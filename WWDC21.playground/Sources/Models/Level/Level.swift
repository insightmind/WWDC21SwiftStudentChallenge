import Foundation

struct Level: Codable {
    // World Information
    let world: GridWorld

    // Static World elements
    let elements: [GridElementType]

    // Computed Elements
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

            case let .movableMirror(node):
                return node

            case let .wall(node):
                return node
            }
        }
    }

    // MARK: - Initializer
    init(world: GridWorld, elements: [GridElement]) {
        self.world = world
        self.elements = elements.map(\.type)
    }
}
