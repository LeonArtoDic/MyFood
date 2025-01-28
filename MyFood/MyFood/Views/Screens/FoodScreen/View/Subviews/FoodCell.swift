import UIKit

final class FoodCell: UITableViewCell {
    
    // MARK: Public properties
    
    var data: FoodItem?
    
    // MARK: Private properties
    
    private let substrateView = UIView()
    private let imageVi = UIImageView()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let ratingView = RatingView()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    

    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Public methods
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        setupData()
        self.layoutIfNeeded() // Tut sporno no rabotaet tolko tak

        var backgroundConf = self.defaultBackgroundConfiguration()
        backgroundConf.customView = substrateView
        backgroundConf.backgroundColor = .orange
        backgroundConf.cornerRadius = 12
        backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
        if state.isSelected || state.isHighlighted {
            backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        }
        
        backgroundConfiguration = backgroundConf
    }
    
    
    // MARK: Private methods
    
    private func setupData() {
        imageVi.image = data?.imageString
        titleLabel.text = data?.title
        ratingView.rating = Double(data?.rating ?? "0") ?? 0
        descriptionLabel.text = data?.description
        priceLabel.text = data?.price
    }
}


// MARK: Setup constraints

extension FoodCell {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel, ratingView, descriptionLabel, priceLabel], 
            axis: .vertical,
            distribution: .equalCentering)
        
        substrateView.addSubview(imageVi)
        substrateView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageVi.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageVi.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 10),
            imageVi.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -10),
            imageVi.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -10),
            imageVi.widthAnchor.constraint(equalTo: imageVi.heightAnchor),
            
            stack.leftAnchor.constraint(equalTo: substrateView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: imageVi.leftAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -10),
            
            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            ratingView.heightAnchor.constraint(lessThanOrEqualToConstant: 15),
            ratingView.widthAnchor.constraint(equalToConstant: 70),
            
            descriptionLabel.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
    }
}
