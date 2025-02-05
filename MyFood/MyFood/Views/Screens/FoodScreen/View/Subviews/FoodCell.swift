import UIKit
import Combine

final class FoodCell: UITableViewCell {
    
    // MARK: Private properties
    
    private let viewModel: ImageCellModelLogic
    private var cancellables = Set<AnyCancellable>()
    
    private let substrateView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let imageVi = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel = UILabel(
        font: .systemFont(ofSize: 18, weight: .bold))
    
    private let ratingView = RatingView()
    
    private let descriptionLabel = UILabel(
        font: .systemFont(ofSize: 13, weight: .regular),
        lines: 3)
    
    private let priceLabel = UILabel(
        font: .systemFont(ofSize: 15, weight: .medium))
    

    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewModel = ImageCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupConstraints()
        bindInner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageVi.image = nil
        viewModel.prepareForReuse()
    }
    
    
    // MARK: Public methods
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        if state.isHighlighted {
            UIView.animate(withDuration: 1) {
                self.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        }
        contentView.transform = .identity
    }

    func setupData(_ data: FoodItem) {
        viewModel.fetchImage(urlString: data.imageString)
        
        titleLabel.text = data.title
        ratingView.rating = data.rating
        descriptionLabel.text = data.description
        priceLabel.text = "$\(data.price)"
    }
}


// MARK: Setup constraints

extension FoodCell {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel, ratingView, descriptionLabel, priceLabel], 
            axis: .vertical,
            spacing: 3,
            distribution: .equalSpacing)
        
        contentView.addSubview(substrateView)
        substrateView.addSubview(imageVi)
        substrateView.addSubview(stack)
        
        substrateView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageVi.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            substrateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            substrateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            substrateView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6),
            substrateView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6),
            
            imageVi.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 8),
            imageVi.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -8),
            imageVi.bottomAnchor.constraint(equalTo: substrateView.bottomAnchor, constant: -8),
            imageVi.widthAnchor.constraint(equalTo: imageVi.heightAnchor),
            
            stack.leftAnchor.constraint(equalTo: substrateView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: imageVi.leftAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: substrateView.bottomAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            
            ratingView.heightAnchor.constraint(equalToConstant: 15),
            ratingView.widthAnchor.constraint(equalToConstant: 70),

            priceLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}


// MARK: - BindingConfigurableView

extension FoodCell {
    func bindInner() {
        viewModel.imageObserver
            .compactMap { $0 }
            .sink { [weak self] image in
                self?.imageVi.image = image
            }
            .store(in: &cancellables)
    }
}
