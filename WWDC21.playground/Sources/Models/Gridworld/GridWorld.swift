import Foundation

struct GridWorld: Codable {
    let size: GridSize

    init(size: GridSize = .init(width: 13, height: 13)) {
        self.size = size
    }
}
