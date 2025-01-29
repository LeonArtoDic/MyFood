import UIKit

extension UILabel {
    convenience init(
        text: String? = nil,
        textColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 20, weight: .regular),
        cornerRadius: CGFloat = 0,
        backColor: UIColor = .clear,
        lines: Int = 0,
        alignment: NSTextAlignment = .left)
    {
        self.init(frame: .zero)
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = lines
        self.textAlignment = alignment
        self.backgroundColor = backColor
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
}
