import UIKit

final class TotalCostCell: UITableViewCell {
        
    // MARK: Private properties
    
    private let titleLabel = UILabel(
        text: "Total",
        font: .systemFont(ofSize: 20, weight: .bold),
        alignment: .left)
    
    private let totalCostLabel = UILabel(
        font: .systemFont(ofSize: 20, weight: .bold),
        lines: 1,
        alignment: .right)
    

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
        
        if state.isSelected || state.isHighlighted {
            backgroundConf.backgroundInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        }
        
        backgroundConfiguration = backgroundConf
    }
    
    func setupData(_ totalCost: Double) {
        let formatedPrice = String(format: "%.2f", totalCost)
        totalCostLabel.text = "$\(formatedPrice)"
    }
}


// MARK: Setup constraints

extension TotalCostCell {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel, totalCostLabel],
            spacing: 5,
            distribution: .fill)
        
        contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
                        
            totalCostLabel.heightAnchor.constraint(equalTo: stack.heightAnchor),
        ])
    }
}
