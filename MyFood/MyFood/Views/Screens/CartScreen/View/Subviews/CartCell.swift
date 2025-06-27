import UIKit

final class CartCell: UITableViewCell {
    
    // MARK: Private properties
    
    private let imageVi = {
        let imageVi = UIImageView()
        imageVi.contentMode = .scaleAspectFill
        imageVi.layer.cornerRadius = 12
        imageVi.clipsToBounds = true
        return imageVi
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    private let priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
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

        var backgroundConf = self.defaultBackgroundConfiguration()
        backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        backgroundConf.backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        backgroundConf.cornerRadius = 8
        backgroundConfiguration = backgroundConf
    }
    
    func setupData(_ data: Order) {
        titleLabel.text = "\(data.title) x\(data.count)"
        let price = data.price * Double(data.count)
        let formatedPrice = String(format: "%.2f", price)
        priceLabel.text = "$\(formatedPrice)"
        
        Task {
            if let image = await ImageLoader.shared.loadImage(from: data.imageString) {
                imageVi.image = image
            } else {
                imageVi.image = .notFound
            }
        }
    }
}


// MARK: Setup constraints

extension CartCell {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [imageVi, titleLabel, priceLabel],
            spacing: 5,
            distribution: .fill)
        
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageVi.heightAnchor.constraint(equalToConstant: 50),
            imageVi.widthAnchor.constraint(equalTo: imageVi.heightAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: stack.heightAnchor),
            
            priceLabel.heightAnchor.constraint(equalTo: stack.heightAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
