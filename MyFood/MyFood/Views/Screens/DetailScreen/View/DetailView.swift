import UIKit

protocol DetailViewLogic: UIView {
    var data: FoodItem? { get set }
    var addToCartButton: UIButton { get }
    var stepperView: StepperView { get set }
}

final class DetailView: UIView, DetailViewLogic {
    
    // MARK: Public properties
    
    var data: FoodItem? {
        didSet {
            setupData()
            checkCart()
        }
    }
    
    var addToCartButton = UIButton()
    var stepperView = StepperView()
    
    
    // MARK: Private properties
    
    private let backView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel = UILabel(
        font: .systemFont(ofSize: 25, weight: .bold))
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return imageView
    }()
    
    private let ratingView = RatingView()
    
    private let descriptionLabel = UILabel(
        font: .systemFont(ofSize: 15, weight: .medium),
        lines: 3)
    
    private var totalPriceLabel = {
        let label = UILabel()
        label.text = "0.00"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        configureAddToCartButton()
        setupConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
    
    private func configureAddToCartButton() {
        var configure = UIButton.Configuration.filled()
        
        configure.title = "Add to cart"
        configure.cornerStyle = .medium
        configure.baseBackgroundColor = #colorLiteral(red: 0.0505053103, green: 0.1062033251, blue: 0.1656947136, alpha: 1)
        
        addToCartButton = UIButton(configuration: configure)
    }
    
    private func setupData() {
        guard let data else { return }
        
        titleLabel.text = data.title
        ratingView.rating = data.rating
        descriptionLabel.text = data.description
        priceLabel.text = "$\(data.price)"
        
        Task {
            if let image = await ImageLoader.shared.loadImage(from: data.imageString) {
                imageView.image = image
            } else {
                imageView.image = .notFound
            }
        }
    }
    
    private func checkCart() {
        guard let data else { return }

        if let order = OrderManager.shared.getOrder(by: data.id) {
            stepperView.value = order.count
            addToCartButton.isHidden = true
            stepperView.isHidden = false
        } else {
            stepperView.isHidden = true
        }
    }
    
    private func addTargets() {
        stepperView.addTarget(self, action: #selector(updateTotalPrice), for: .valueChanged)
    }
    
    @objc private func updateTotalPrice() {
        guard let data else { return }
        
        if stepperView.value == 0 {
            stepperView.isHidden = true
            addToCartButton.isHidden = false
        }
            
        let price = (data.price) * Double(stepperView.value)
        let formatedPrice = String(format: "%.2f", price)
        totalPriceLabel.text = "$\(formatedPrice)"
    }
}


// MARK: Setup constraints

extension DetailView {
    
    private func setupConstraints() {
        let descriptionStack = UIStackView(
            arrangedSubviews: [titleLabel, imageView, ratingView, descriptionLabel],
            axis: .vertical,
            spacing: 10
        )
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.addSubview(descriptionStack)
        addSubview(backView)
        addSubview(totalPriceLabel)
        addSubview(priceLabel)
        addSubview(addToCartButton)
        addSubview(stepperView)
        
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            backView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 10),
            
            descriptionStack.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 10),
            descriptionStack.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -10),
            descriptionStack.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            priceLabel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            priceLabel.rightAnchor.constraint(equalTo: backView.rightAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            totalPriceLabel.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 100),
            totalPriceLabel.leftAnchor.constraint(equalTo: backView.leftAnchor),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 50),
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            addToCartButton.topAnchor.constraint(equalTo: totalPriceLabel.topAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor),
            addToCartButton.leftAnchor.constraint(equalTo: totalPriceLabel.rightAnchor, constant: 5),
            addToCartButton.rightAnchor.constraint(equalTo: backView.rightAnchor),
            
            stepperView.topAnchor.constraint(equalTo: totalPriceLabel.topAnchor),
            stepperView.bottomAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor),
            stepperView.leftAnchor.constraint(equalTo: totalPriceLabel.rightAnchor, constant: 8),
            stepperView.rightAnchor.constraint(equalTo: backView.rightAnchor)
        ])
    }
}
