import UIKit

extension UIColor {
    static let charcoal: UIColor = .init(hex: "264653")
    static let persianGreen: UIColor = .init(hex: "2A9D8F")
    static let crayola: UIColor = .init(hex: "E9C46A")
    static let sandyBrown: UIColor = .init(hex: "F4A261")
    static let burntSienna: UIColor = .init(hex: "E76F51")
    static let almondWhite: UIColor = .init(hex: "FDF4EC")
    static let smokyBlack: UIColor = .init(hex: "120A02")

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
