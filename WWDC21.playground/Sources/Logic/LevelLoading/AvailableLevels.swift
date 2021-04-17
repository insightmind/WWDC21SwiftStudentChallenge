import Foundation

enum AvailableLevels: Equatable {
    case debug1
    case debug2

    case level(index: Int)

    // MARK: - Public Properties
    func load() -> Level? {
        guard let path = Bundle.main.url(forResource: filePath, withExtension: FileExtension.qlev.rawValue) else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }

        level2.printPretty()

        let decoder = JSONDecoder()
        return try? decoder.decode(Level.self, from: data)
    }

    var next: AvailableLevels {
        switch self {
        case .debug1, .debug2:
            return self

        case let .level(index):
            return .level(index: index + 1)
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
