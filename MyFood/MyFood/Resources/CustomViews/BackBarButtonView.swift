import UIKit

class BackBarButtonView: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.setImage(.back, for: .normal)

        let attrString = NSAttributedString(string: "goBack", attributes: [.font: UIFont.systemFont(ofSize: 17)])
        self.setAttributedTitle(attrString, for: .normal)
        
        self.semanticContentAttribute = .forceLeftToRight
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -8, bottom: 0, trailing: 0)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
