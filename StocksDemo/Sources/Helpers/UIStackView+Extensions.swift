import UIKit.UIStackView

extension UIStackView {
    func removeAllArangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
        }
    }
}
