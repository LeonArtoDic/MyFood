import UIKit

extension UIButton {
    convenience init(
        backColor: UIColor = .white,
        cornerRadius: CGFloat = 0)
    {
        self.init(frame: .zero)
        self.backgroundColor = backColor
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
}

