import UIKit.UIColor

extension UIColor {
    static let background = UIColor(named: "background")
    
    static var cmykGreen: UIColor {
        guard let cmykGreenColor = UIColor(named: "cmykGreen") else  {
            return .green
        }
        return cmykGreenColor
    }
    
    static var cmykRed: UIColor {
        guard let cmykRedColor = UIColor(named: "cmykRed") else {
            return .red
        }
        return cmykRedColor
    }
    
    static let filled = UIColor(named: "filled")
}
