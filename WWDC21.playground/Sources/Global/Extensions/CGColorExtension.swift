import UIKit

extension CGColor {
    static func from(hex: String) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
}
