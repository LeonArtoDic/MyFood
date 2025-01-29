import UIKit

protocol DetailView: UIView { }

final class DetailViewImpl: UIView, DetailView {
    
    // MARK: Private properties
    
    private let titleLabel = UILabel(
        text: "Name",
        font: .systemFont(ofSize: 25, weight: .bold))
    
    private let imageView = {
        let imageView = UIImageView(image: .foodOne)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.8187198043, green: 0.9357115626, blue: 0.731353581, alpha: 1)
        return imageView
    }()
    
    private let descriptionLabel = UILabel(
        text: "Guy's BBQ Trash Can Nachos + Caliente Margaritas Ribs & Chicken Combo Pack - Serves 6-8",
        font: .systemFont(ofSize: 15, weight: .medium),
        lines: 3)
    
    private let stepperView = StepperView()
    
    private let totalPriceLabel = UILabel(
        text: "$100",
        font: .systemFont(ofSize: 20, weight: .bold),
        cornerRadius: 10,
        backColor: #colorLiteral(red: 0.8187198043, green: 0.9357115626, blue: 0.731353581, alpha: 1),
        alignment: .center)
    
    private let addToCartButton = {
        let button = UIButton(type: .system)
        let attrString = NSAttributedString(
            string: "Add to cart", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        )
        button.setAttributedTitle(attrString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
    
    private func addTargets() {
        stepperView.addTarget(self, action: #selector(updateTotalPrice), for: .valueChanged)
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
    }
    
    @objc private func updateTotalPrice() {
        totalPriceLabel.text = "$\(100 * stepperView.value)"
    }
    
    @objc private func addToCartTapped() {
        print("🛍️ Added to cart")
    }
}


//MARK: Setup constraints

extension DetailViewImpl {
    
    private func setupConstraints() {
        let descriptionStack = UIStackView(
            arrangedSubviews: [titleLabel, imageView, descriptionLabel],
            axis: .vertical,
            spacing: 10
        )
        
        let orderStack = UIStackView(
            arrangedSubviews: [totalPriceLabel, addToCartButton],
            spacing: 7
        )
        
        descriptionStack.translatesAutoresizingMaskIntoConstraints = false
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        orderStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionStack)
        addSubview(stepperView)
        addSubview(orderStack)
        
        NSLayoutConstraint.activate([
            descriptionStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            descriptionStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            descriptionStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            stepperView.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 40),
            stepperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            orderStack.leftAnchor.constraint(equalTo: descriptionStack.leftAnchor),
            orderStack.rightAnchor.constraint(equalTo: descriptionStack.rightAnchor),
            orderStack.topAnchor.constraint(equalTo: stepperView.bottomAnchor, constant: 30),
            orderStack.heightAnchor.constraint(equalToConstant: 50),
            
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 100),
            totalPriceLabel.heightAnchor.constraint(equalTo: orderStack.heightAnchor),
            
            addToCartButton.heightAnchor.constraint(equalTo: orderStack.heightAnchor)
        ])
    }
}
