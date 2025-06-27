import UIKit

final class CategoryCell: UICollectionViewCell {
    
    // MARK: Private properties
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blackoutView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view
    }()
    
    private let titleLabel = UILabel(
        textColor: .white,
        font: .systemFont(ofSize: 20, weight: .bold),
        alignment: .center)
    
    
    // MARK: Public methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.addSubview(blackoutView)
        imageView.addSubview(titleLabel)
        
        blackoutView.frame = bounds
        titleLabel.frame = bounds
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
                
        var backgroundConf = self.defaultBackgroundConfiguration()
        
        backgroundConf.cornerRadius = 12
        backgroundConf.customView = imageView
        
        backgroundConfiguration = backgroundConf
    }

    func setupData(_ data: CategoryItem) {
        imageView.image = data.image
        titleLabel.text = data.title
    }
}
