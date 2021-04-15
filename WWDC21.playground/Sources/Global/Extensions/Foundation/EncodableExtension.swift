import Foundation

extension Encodable {
    func printPretty() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(self)
            print(String(data: data, encoding: .utf8) ?? "Unknown data")
        } catch {
            print("Error occured while encoding data: \(String(describing: Self.self)); \(error.localizedDescription)")
        }
    }
}
