import UIKit

final class CartCell: UITableViewCell {
    
    // MARK: Private properties
    
    private let numberLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        return label
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
        backgroundConf.backgroundColor = #colorLiteral(red: 1, green: 0.9926504493, blue: 0.9357290864, alpha: 1)
        backgroundConf.cornerRadius = 8
        backgroundConfiguration = backgroundConf
    }
    
    func setupData(_ data: Product) {
        titleLabel.text = data.title
        priceLabel.text = "$\(data.price)"
        numberLabel.text =  "\((data.id) + 1)"
    }
}


// MARK: Setup constraints

extension CartCell {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [numberLabel, titleLabel, priceLabel],
            spacing: 5,
            distribution: .fill)
        
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            numberLabel.widthAnchor.constraint(equalTo:numberLabel.heightAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: stack.heightAnchor),
            
            priceLabel.heightAnchor.constraint(equalTo: stack.heightAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
