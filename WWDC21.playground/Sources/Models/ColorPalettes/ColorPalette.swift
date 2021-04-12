import UIKit

struct ColorPalette {
    let colors: [UIColor]
    let backgroundColor: UIColor

    func color(index: Int) -> UIColor {
        guard colors.count > 0 else { return .black }
        return colors[index % colors.count]
    }
}
