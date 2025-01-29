import UIKit

final class CategoryCell: UICollectionViewCell {
    
    // MARK: Public properties
    
    var data: CategoryItem?
    
    // MARK: Private properties
    
    private let imageView = UIImageView()
    
    private let blackoutView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
    private lazy var titleLabel = UILabel(
        textColor: .white,
        font: .systemFont(ofSize: 20, weight: .bold),
        alignment: .center)
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        setupData()
        
        var backgroundConf = self.defaultBackgroundConfiguration()
        
        backgroundConf.backgroundColor = .red
        backgroundConf.cornerRadius = 12

        backgroundConf.customView = imageView
                
        if state.isSelected || state.isHighlighted {
            backgroundConf.backgroundColor = .green
            backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        }
        
        backgroundConfiguration = backgroundConf
    }
    
    
    // MARK: Private methods
    
    private func setupData() {
        imageView.image = data?.imageString
        titleLabel.text = data?.title
    }
}


// MARK: Setup constraints

extension CategoryCell {
    
    private func setupConstraints() {
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(blackoutView)
        blackoutView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            blackoutView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            blackoutView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            blackoutView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blackoutView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: blackoutView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: blackoutView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: blackoutView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: blackoutView.bottomAnchor)
        ])
    }
}
