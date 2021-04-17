import Foundation

enum AvailableLevels: Equatable {
    case debug1
    case debug2

    case level(index: Int)

    // MARK: - Public Properties
    func load() -> Level? {
        guard let path = Bundle.main.url(forResource: filePath, withExtension: FileExtension.qlev.rawValue) else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }

        level6.printPretty()

        let decoder = JSONDecoder()
        return try? decoder.decode(Level.self, from: data)
    }

    var next: AvailableLevels? {
        switch self {
        case .debug1, .debug2:
            return self

        case let .level(index):
            if index > 0 && index < 8 {
                return .level(index: index + 1)
            } else {
                return nil
            }
        }
    }

    var name: String {
        switch self {
        case let .level(index):
            return "Level \(index)"

        default:
            return filename
        }
    }

    // MARK: - Private Properties
    private static let basePath: String = "Levels/"
    private var filename: String {
        switch self {
        case .debug1:
            return "Debug_01"

        case .debug2:
            return "Debug_02"

        case let .level(index):
            return "Level_\(index)"
        }
    }

    private var filePath: String {
        return Self.basePath + filename
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.filePath == rhs.filePath
    }
}

let level1: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 3, yIndex: 3), emitDirection: .right, emissionGroup: .red, movableOption: .init(secondPosition: .init(xIndex: 3, yIndex: 10), initialProgress: 1.0)),
        
        GridWall(position: .init(xIndex: 8, yIndex: 13)),
        GridWall(position: .init(xIndex: 8, yIndex: 12)),
        GridWall(position: .init(xIndex: 8, yIndex: 11)),
        GridWall(position: .init(xIndex: 8, yIndex: 10)),
        GridWall(position: .init(xIndex: 8, yIndex: 9)),
        GridWall(position: .init(xIndex: 8, yIndex: 8)),

        GridWall(position: .init(xIndex: 8, yIndex: 6)),
        GridWall(position: .init(xIndex: 8, yIndex: 5)),
        GridWall(position: .init(xIndex: 8, yIndex: 4)),
        GridWall(position: .init(xIndex: 8, yIndex: 3)),
        GridWall(position: .init(xIndex: 8, yIndex: 2)),
        GridWall(position: .init(xIndex: 8, yIndex: 1)),

        GridReceiver(position: .init(xIndex: 11, yIndex: 7), receiveDirection: .left, receiveGroup: .red),
    ]
)

let level2: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 3, yIndex: 3), emitDirection: .right, emissionGroup: .blue, movableOption: .init(secondPosition: .init(xIndex: 3, yIndex: 11), initialProgress: 0.0)),
        GridEmitter(position: .init(xIndex: 5, yIndex: 3), emitDirection: .right, emissionGroup: .green, movableOption: .init(secondPosition: .init(xIndex: 5, yIndex: 11), initialProgress: 1.0)),

        GridWall(position: .init(xIndex: 8, yIndex: 13)),
        GridWall(position: .init(xIndex: 8, yIndex: 12)),
        GridWall(position: .init(xIndex: 8, yIndex: 11)),

        GridGroupWall(position: .init(xIndex: 8, yIndex: 10), group: .blue),

        GridWall(position: .init(xIndex: 8, yIndex: 9)),
        GridWall(position: .init(xIndex: 8, yIndex: 8)),
        GridWall(position: .init(xIndex: 8, yIndex: 7)),
        GridWall(position: .init(xIndex: 8, yIndex: 6)),
        GridWall(position: .init(xIndex: 8, yIndex: 5)),

        GridGroupWall(position: .init(xIndex: 8, yIndex: 4), group: .blue),

        GridWall(position: .init(xIndex: 8, yIndex: 3)),
        GridWall(position: .init(xIndex: 8, yIndex: 2)),
        GridWall(position: .init(xIndex: 8, yIndex: 1)),

        GridReceiver(position: .init(xIndex: 11, yIndex: 10), receiveDirection: .left, receiveGroup: .blue),
        GridReceiver(position: .init(xIndex: 11, yIndex: 4), receiveDirection: .left, receiveGroup: .green),
    ]
)

let level3: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 3, yIndex: 12), emitDirection: .down, emissionGroup: .yellow),

        GridWall(position: .init(xIndex: 8, yIndex: 13)),
        GridWall(position: .init(xIndex: 8, yIndex: 12)),
        GridWall(position: .init(xIndex: 8, yIndex: 11)),
        GridWall(position: .init(xIndex: 8, yIndex: 10)),
        GridWall(position: .init(xIndex: 8, yIndex: 9)),
        GridWall(position: .init(xIndex: 8, yIndex: 8)),

        GridWall(position: .init(xIndex: 8, yIndex: 5)),
        GridWall(position: .init(xIndex: 8, yIndex: 4)),
        GridWall(position: .init(xIndex: 8, yIndex: 3)),
        GridWall(position: .init(xIndex: 8, yIndex: 2)),
        GridWall(position: .init(xIndex: 8, yIndex: 1)),

        GridReceiver(position: .init(xIndex: 11, yIndex: 12), receiveDirection: .left, receiveGroup: .yellow),

        GridTransmitter(position: .init(xIndex: 2, yIndex: 8), emitDirections: [.right], receiveDirections: [.up], movableOption: .init(secondPosition: .init(xIndex: 5, yIndex: 4), initialProgress: 0.0), emissionGroup: .purple),
        GridTransmitter(position: .init(xIndex: 12, yIndex: 8), emitDirections: [.up], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 10, yIndex: 4), initialProgress: 0.0), emissionGroup: .yellow)
    ]
)

let level4: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 3, yIndex: 12), emitDirection: .right, emissionGroup: .red),

        GridWall(position: .init(xIndex: 6, yIndex: 13)),
        GridWall(position: .init(xIndex: 6, yIndex: 9)),
        GridWall(position: .init(xIndex: 6, yIndex: 5)),
        GridWall(position: .init(xIndex: 6, yIndex: 1)),

        GridWall(position: .init(xIndex: 8, yIndex: 11)),
        GridWall(position: .init(xIndex: 8, yIndex: 3)),

        GridGroupWall(position: .init(xIndex: 7, yIndex: 12), group: .red),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 10), group: .green),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 8), group: .yellow),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 7), group: .yellow),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 6), group: .yellow),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 4), group: .red),
        GridGroupWall(position: .init(xIndex: 7, yIndex: 2), group: .green),

        GridReceiver(position: .init(xIndex: 5, yIndex: 4), receiveDirection: .left, receiveGroup: .red),

        GridTransmitter(position: .init(xIndex: 12, yIndex: 13), emitDirections: [.leftDown], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 12, yIndex: 4), initialProgress: 1.0), emissionGroup: .yellow),
        GridTransmitter(position: .init(xIndex: 3, yIndex: 2), emitDirections: [.up], receiveDirections: [.rightUp], movableOption: .init(secondPosition: .init(xIndex: 3, yIndex: 6), initialProgress: 0.0), emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 5, yIndex: 10), emitDirections: [.right], receiveDirections: [.down], movableOption: .init(secondPosition: .init(xIndex: 2, yIndex: 7), initialProgress: 0.0), emissionGroup: .yellow),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 8), emitDirections: [.down], receiveDirections: [.left], emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 4), emitDirections: [.left], receiveDirections: [.up], emissionGroup: .red)
    ]
)

let level5: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 12, yIndex: 3), emitDirection: .left, emissionGroup: .red),

        GridWall(position: .init(xIndex: 2, yIndex: 12)),
        GridWall(position: .init(xIndex: 2, yIndex: 11)),
        GridWall(position: .init(xIndex: 2, yIndex: 10)),
        GridWall(position: .init(xIndex: 2, yIndex: 9)),
        GridWall(position: .init(xIndex: 2, yIndex: 8)),
        GridWall(position: .init(xIndex: 2, yIndex: 7)),
        GridWall(position: .init(xIndex: 2, yIndex: 6)),
        GridWall(position: .init(xIndex: 2, yIndex: 5)),
        GridWall(position: .init(xIndex: 2, yIndex: 4)),
        GridWall(position: .init(xIndex: 2, yIndex: 3)),
        GridWall(position: .init(xIndex: 2, yIndex: 2)),

        GridWall(position: .init(xIndex: 3, yIndex: 12)),
        GridWall(position: .init(xIndex: 4, yIndex: 12)),
        GridWall(position: .init(xIndex: 5, yIndex: 12)),
        GridWall(position: .init(xIndex: 6, yIndex: 12)),
        GridWall(position: .init(xIndex: 7, yIndex: 12)),
        GridWall(position: .init(xIndex: 8, yIndex: 12)),
        GridWall(position: .init(xIndex: 9, yIndex: 12)),
        GridWall(position: .init(xIndex: 10, yIndex: 12)),
        GridWall(position: .init(xIndex: 11, yIndex: 12)),

        GridWall(position: .init(xIndex: 11, yIndex: 11)),
        GridWall(position: .init(xIndex: 11, yIndex: 10)),
        GridWall(position: .init(xIndex: 11, yIndex: 9)),
        GridWall(position: .init(xIndex: 11, yIndex: 8)),
        GridWall(position: .init(xIndex: 11, yIndex: 7)),
        GridWall(position: .init(xIndex: 11, yIndex: 6)),
        GridWall(position: .init(xIndex: 11, yIndex: 5)),
        GridWall(position: .init(xIndex: 11, yIndex: 4)),

        GridWall(position: .init(xIndex: 10, yIndex: 4)),
        GridWall(position: .init(xIndex: 9, yIndex: 4)),
        GridWall(position: .init(xIndex: 8, yIndex: 4)),
        GridWall(position: .init(xIndex: 6, yIndex: 4)),
        GridWall(position: .init(xIndex: 5, yIndex: 4)),
        GridWall(position: .init(xIndex: 4, yIndex: 4)),

        GridWall(position: .init(xIndex: 4, yIndex: 5)),
        GridWall(position: .init(xIndex: 4, yIndex: 6)),
        GridWall(position: .init(xIndex: 4, yIndex: 7)),
        GridWall(position: .init(xIndex: 4, yIndex: 8)),
        GridWall(position: .init(xIndex: 4, yIndex: 9)),
        GridWall(position: .init(xIndex: 4, yIndex: 10)),

        GridWall(position: .init(xIndex: 5, yIndex: 10)),
        GridWall(position: .init(xIndex: 6, yIndex: 10)),
        GridWall(position: .init(xIndex: 7, yIndex: 10)),
        GridWall(position: .init(xIndex: 8, yIndex: 10)),
        GridWall(position: .init(xIndex: 9, yIndex: 10)),

        GridWall(position: .init(xIndex: 9, yIndex: 9)),
        GridWall(position: .init(xIndex: 9, yIndex: 8)),
        GridWall(position: .init(xIndex: 9, yIndex: 7)),
        GridWall(position: .init(xIndex: 9, yIndex: 6)),

        GridWall(position: .init(xIndex: 8, yIndex: 6)),
        GridWall(position: .init(xIndex: 6, yIndex: 6)),

        GridWall(position: .init(xIndex: 6, yIndex: 7)),
        GridWall(position: .init(xIndex: 6, yIndex: 8)),

        GridWall(position: .init(xIndex: 7, yIndex: 8)),

        GridReceiver(position: .init(xIndex: 7, yIndex: 2), receiveDirection: .up, receiveGroup: .red),

        GridTransmitter(position: .init(xIndex: 7, yIndex: 7), emitDirections: [.down], receiveDirections: [.right], emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 8, yIndex: 7), emitDirections: [.left], receiveDirections: [.up], emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 8, yIndex: 9), emitDirections: [.down], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 8, yIndex: 8), initialProgress: 1.0), emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 5, yIndex: 9), emitDirections: [.right], receiveDirections: [.down], movableOption: .init(secondPosition: .init(xIndex: 7, yIndex: 9), initialProgress: 1.0), emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 5, yIndex: 5), emitDirections: [.up], receiveDirections: [.right], movableOption: .init(secondPosition: .init(xIndex: 5, yIndex: 8), initialProgress: 1.0), emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 5), emitDirections: [.left], receiveDirections: [.up], movableOption: .init(secondPosition: .init(xIndex: 6, yIndex: 5), initialProgress: 1.0), emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 11), emitDirections: [.down], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 10, yIndex: 6), initialProgress: 1.0), emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 3, yIndex: 11), emitDirections: [.right], receiveDirections: [.down], movableOption: .init(secondPosition: .init(xIndex: 9, yIndex: 11), initialProgress: 1.0), emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 3, yIndex: 2), emitDirections: [.up], receiveDirections: [.right], movableOption: .init(secondPosition: .init(xIndex: 3, yIndex: 10), initialProgress: 1.0), emissionGroup: .red)
    ]
)

let level6: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 2, yIndex: 10), emitDirection: .right, emissionGroup: .red, movableOption: .init(secondPosition: .init(xIndex: 2, yIndex: 12))),
        GridEmitter(position: .init(xIndex: 2, yIndex: 6), emitDirection: .down, emissionGroup: .yellow, movableOption: .init(secondPosition: .init(xIndex: 4, yIndex: 6))),
        GridEmitter(position: .init(xIndex: 11, yIndex: 2), emitDirection: .left, emissionGroup: .green),

        GridWall(position: .init(xIndex: 7, yIndex: 13)),
        GridWall(position: .init(xIndex: 6, yIndex: 11)),
        GridWall(position: .init(xIndex: 6, yIndex: 10)),
        GridWall(position: .init(xIndex: 7, yIndex: 8)),
        GridWall(position: .init(xIndex: 8, yIndex: 7)),
        GridWall(position: .init(xIndex: 12, yIndex: 7)),
        GridWall(position: .init(xIndex: 12, yIndex: 8)),

        GridGroupWall(position: .init(xIndex: 8, yIndex: 2), group: .blue),
        GridGroupWall(position: .init(xIndex: 3, yIndex: 4), group: .blue),

        GridGroupWall(position: .init(xIndex: 9, yIndex: 7), group: .green),
        GridGroupWall(position: .init(xIndex: 10, yIndex: 7), group: .green),
        GridGroupWall(position: .init(xIndex: 11, yIndex: 7), group: .green),

        GridGroupWall(position: .init(xIndex: 6, yIndex: 12), group: .red),
        GridGroupWall(position: .init(xIndex: 6, yIndex: 9), group: .red),
        GridGroupWall(position: .init(xIndex: 9, yIndex: 6), group: .red),
        GridGroupWall(position: .init(xIndex: 10, yIndex: 6), group: .red),
        GridGroupWall(position: .init(xIndex: 11, yIndex: 6), group: .red),

        GridGroupWall(position: .init(xIndex: 2, yIndex: 3), group: .red),
        GridGroupWall(position: .init(xIndex: 3, yIndex: 3), group: .red),
        GridGroupWall(position: .init(xIndex: 4, yIndex: 3), group: .red),
        GridGroupWall(position: .init(xIndex: 4, yIndex: 2), group: .red),
        GridGroupWall(position: .init(xIndex: 4, yIndex: 1), group: .red),

        GridReceiver(position: .init(xIndex: 3, yIndex: 2), receiveDirection: .right, receiveGroup: .green),

        GridReceiver(position: .init(xIndex: 10, yIndex: 12), receiveDirection: .down, receiveGroup: .red),
        GridReceiver(position: .init(xIndex: 7, yIndex: 4), receiveDirection: .down, receiveGroup: .red),

        GridReceiver(position: .init(xIndex: 8, yIndex: 11), receiveDirection: .leftUp, receiveGroup: .blue),
        GridReceiver(position: .init(xIndex: 8, yIndex: 9), receiveDirection: .right, receiveGroup: .blue),

        GridReceiver(position: .init(xIndex: 12, yIndex: 9), receiveDirection: .left, receiveGroup: .yellow),

        GridTransmitter(position: .init(xIndex: 3, yIndex: 10), emitDirections: [.rightDown], receiveDirections: [.left], emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 10), emitDirections: [.up], receiveDirections: [.down], emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 7, yIndex: 2), emitDirections: [.up, .left], receiveDirections: [.right], emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 4), emitDirections: [.up], receiveDirections: [.leftUp], emissionGroup: .red),

        GridTransmitter(position: .init(xIndex: 7, yIndex: 12), emitDirections: [.rightDown], receiveDirections: [.left], emissionGroup: .blue),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 9), emitDirections: [.left, .up, .right], receiveDirections: [.down], emissionGroup: .blue),

        GridTransmitter(position: .init(xIndex: 11, yIndex: 9), emitDirections: [.right], receiveDirections: [.left], emissionGroup: .yellow),

        GridTransmitter(position: .init(xIndex: 5, yIndex: 2), emitDirections: [.left], receiveDirections: [.right], emissionGroup: .green),
    ]
)

let level7: Level = .init(
    world: .init(size: .init(width: 13, height: 13)),
    elements: [
        GridEmitter(position: .init(xIndex: 2, yIndex: 10), emitDirection: .right, emissionGroup: .red),
        GridEmitter(position: .init(xIndex: 2, yIndex: 8), emitDirection: .right, emissionGroup: .green),
        GridEmitter(position: .init(xIndex: 2, yIndex: 6), emitDirection: .right, emissionGroup: .orange),

        GridEmitter(position: .init(xIndex: 11, yIndex: 9), emitDirection: .left, emissionGroup: .blue),
        GridEmitter(position: .init(xIndex: 11, yIndex: 7), emitDirection: .left, emissionGroup: .purple),
        GridEmitter(position: .init(xIndex: 11, yIndex: 5), emitDirection: .left, emissionGroup: .pink),

        GridWall(position: .init(xIndex: 4, yIndex: 9)),
        GridWall(position: .init(xIndex: 6, yIndex: 12)),
        GridWall(position: .init(xIndex: 8, yIndex: 12)),
        GridWall(position: .init(xIndex: 9, yIndex: 12)),
        GridWall(position: .init(xIndex: 11, yIndex: 6)),
        GridWall(position: .init(xIndex: 8, yIndex: 4)),

        GridReceiver(position: .init(xIndex: 5, yIndex: 12), receiveDirection: .down, receiveGroup: .pink),
        GridReceiver(position: .init(xIndex: 7, yIndex: 12), receiveDirection: .down, receiveGroup: .red),
        GridReceiver(position: .init(xIndex: 10, yIndex: 12), receiveDirection: .down, receiveGroup: .purple),

        GridReceiver(position: .init(xIndex: 7, yIndex: 2), receiveDirection: .up, receiveGroup: .orange),
        GridReceiver(position: .init(xIndex: 9, yIndex: 3), receiveDirection: .up, receiveGroup: .blue),

        GridReceiver(position: .init(xIndex: 12, yIndex: 8), receiveDirection: .left, receiveGroup: .green),

        GridTransmitter(position: .init(xIndex: 7, yIndex: 8), emitDirections: [.down], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 11, yIndex: 12), initialProgress: 1.0), emissionGroup: .blue),
        GridTransmitter(position: .init(xIndex: 6, yIndex: 7), emitDirections: [.right], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 6, yIndex: 9), initialProgress: 0.5), emissionGroup: .green),
        GridTransmitter(position: .init(xIndex: 4, yIndex: 12), emitDirections: [.up], receiveDirections: [.right], movableOption: .init(secondPosition: .init(xIndex: 8, yIndex: 8), initialProgress: 1.0), emissionGroup: .red),
        GridTransmitter(position: .init(xIndex: 7, yIndex: 3), emitDirections: [.up], receiveDirections: [.right], movableOption: .init(secondPosition: .init(xIndex: 3, yIndex: 7), initialProgress: 0.0), emissionGroup: .pink),
        GridTransmitter(position: .init(xIndex: 10, yIndex: 3), emitDirections: [.up], receiveDirections: [.right], movableOption: .init(secondPosition: .init(xIndex: 10, yIndex: 10), initialProgress: 1.0), emissionGroup: .purple),
        GridTransmitter(position: .init(xIndex: 6, yIndex: 5), emitDirections: [.down], receiveDirections: [.left], movableOption: .init(secondPosition: .init(xIndex: 8, yIndex: 7), initialProgress: 0.0), emissionGroup: .orange),
    ]
)
