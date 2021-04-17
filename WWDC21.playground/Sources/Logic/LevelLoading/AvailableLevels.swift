import Foundation

enum AvailableLevels: Equatable {
    case debug1
    case debug2
    case empty

    case level(index: Int)

    // MARK: - Public Properties
    func load() -> Level? {
        guard let path = Bundle.main.url(forResource: filePath, withExtension: FileExtension.qlev.rawValue) else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }

        let decoder = JSONDecoder()
        return try? decoder.decode(Level.self, from: data)
    }

    var next: AvailableLevels? {
        switch self {
        case .debug1, .debug2, .empty:
            return self

        case let .level(index):
            if index > 0 && index < 7 {
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
            return ""
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

        case .empty:
            return "Empty"

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
