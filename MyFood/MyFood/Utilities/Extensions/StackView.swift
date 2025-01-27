import UIKit

extension UIStackView {
    
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .horizontal,
        alignment: UIStackView.Alignment = .leading,
        distribution: UIStackView.Distribution = .fillEqually)
    {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
    }
}
