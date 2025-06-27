import UIKit

class RatingView: UIView {
    
    // MARK: - Private properties
    
    private let maxStars = 5
    private var starImageViews: [UIImageView] = []
    
    
    // MARK: - Public properties
    
    var rating: Int = 0 {
        didSet {
            updateStars()
        }
    }
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }
    
    
    // MARK: - Private methods
    
    private func setupStars() {
        for _ in 0..<maxStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "star")
            starImageViews.append(imageView)
        }
        
        layoutStars()
    }
    
    private func layoutStars() {
        let stack = UIStackView(arrangedSubviews: starImageViews)
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func updateStars() {
        for (index, star) in starImageViews.enumerated() {
            if index < rating {
                if rating - index >= 1 {
                    star.image = UIImage(systemName: "star.fill")
                    star.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                } else {
                    star.image = UIImage(systemName: "star.leadinghalf.filled")
                    star.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                }
            } else {
                star.image = UIImage(systemName: "star")
                star.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
}
