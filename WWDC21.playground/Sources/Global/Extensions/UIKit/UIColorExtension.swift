import UIKit

extension UIColor {
    static let darkPurple: UIColor = .init(hex: "121417")
    static let flickrPink: UIColor = .init(hex: "F72585")
    static let neonPurple: UIColor = .init(hex: "7209B7")
    static let persianBlue: UIColor = .init(hex: "3F37C9")
    static let vividBlue: UIColor = .init(hex: "4CC9F0")
    static let russianViolet: UIColor = .init(hex: "20064B")
    static let backgroundGray: UIColor = .init(hex: "95A7A8")

    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber), hex.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
            print("Failed parsing: \(hex) with count \(hex.count), returning black")
            return
        }

        let red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        let green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        let blue = CGFloat(hexNumber & 0x0000ff) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
