import Foundation

enum GridElementType: Codable {
    case emitter(GridEmitter)
    case transmitter(GridTransmitter)
    case receiver(GridReceiver)
    case mirror(GridMirror)
    case wall(GridMirror)

    enum CodingKeys: CodingKey {
        case type
        case element
    }

    enum Identifier: String {
        case emitter
        case transmitter
        case receiver
        case mirror
        case wall
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        switch try container.decode(String.self, forKey: .type) {
        case Identifier.emitter.rawValue:
            self = .emitter(try container.decode(GridEmitter.self, forKey: .element))

        case Identifier.transmitter.rawValue:
            self = .transmitter(try container.decode(GridTransmitter.self, forKey: .element))

        case Identifier.receiver.rawValue:
            self = .receiver(try container.decode(GridReceiver.self, forKey: .element))

        case Identifier.mirror.rawValue:
            self = .mirror(try container.decode(GridMirror.self, forKey: .element))

        case Identifier.wall.rawValue:
            self = .wall(try container.decode(GridMirror.self, forKey: .element))

        default:
            throw DecodingError.typeMismatch(GridElementType.self, .init(codingPath: decoder.codingPath, debugDescription: "GridElementType decoding failed"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .emitter(node):
            try container.encode(Identifier.emitter.rawValue, forKey: .type)
            try container.encode(node, forKey: .element)

        case let .transmitter(node):
            try container.encode(Identifier.transmitter.rawValue, forKey: .type)
            try container.encode(node, forKey: .element)

        case let .receiver(node):
            try container.encode(Identifier.receiver.rawValue, forKey: .type)
            try container.encode(node, forKey: .element)

        case let .mirror(node):
            try container.encode(Identifier.mirror.rawValue, forKey: .type)
            try container.encode(node, forKey: .element)

        case let .wall(node):
            try container.encode(Identifier.wall.rawValue, forKey: .type)
            try container.encode(node, forKey: .element)
        }
    }
}

protocol GridElement: Codable {
    var type: GridElementType { get }
    var position: GridPosition { get }

    func generateNode() -> GridNode
}
