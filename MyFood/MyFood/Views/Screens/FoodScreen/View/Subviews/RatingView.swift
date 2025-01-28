import UIKit

class RatingView: UIView {
    
    private let maxStars = 5
    private var starImageViews: [UIImageView] = []
    
    var rating: Double = 0 {
        didSet {
            updateStars()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }
    
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
            if Double(index) < rating {
                if rating - Double(index) >= 1 {
                    star.image = UIImage(systemName: "star.fill")
                    star.tintColor = .yellow
                } else {
                    star.image = UIImage(systemName: "star.leadinghalf.filled")
                    star.tintColor = .yellow
                }
            } else {
                star.image = UIImage(systemName: "star")
                star.tintColor = .yellow
            }
        }
    }
}
