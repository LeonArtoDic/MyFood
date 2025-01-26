import UIKit

final class CategoryCell: UICollectionViewCell {
    var data: CategoryItem?
    
    // MARK: Private properties
    
    private lazy var imageView = {
        let imageView = UIImageView(image: self.data?.imageString)
        return imageView
    }()
    
    private let blackoutView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
    private lazy var titleView = {
        let view = UILabel()
        view.text = data?.title
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    
    // MARK: Private methods
    
    public override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var backgroundConf = self.defaultBackgroundConfiguration()
        
        backgroundConf.backgroundColor = .red
        backgroundConf.cornerRadius = 12
        
        addSubviews()
        setupConstraints()

        backgroundConf.customView = imageView
                
        if state.isSelected || state.isHighlighted {
            backgroundConf.backgroundColor = .green
            backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        }
        
        backgroundConfiguration = backgroundConf
    }
}


// MARK: Setup constraints methods

extension CategoryCell {
    
    private func addSubviews() {
        imageView.addSubview(blackoutView)
        blackoutView.addSubview(titleView)
    }
    
    private func setupConstraints() {
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blackoutView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            blackoutView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            blackoutView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blackoutView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            titleView.leftAnchor.constraint(equalTo: blackoutView.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: blackoutView.rightAnchor),
            titleView.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            titleView.bottomAnchor.constraint(equalTo: blackoutView.bottomAnchor)
        ])
    }
}
