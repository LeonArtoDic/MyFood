import UIKit

final class StepperView: UIControl {
    
    // MARK: Private properties
    
    private let decrementButton = {
        let button = UIButton(backColor: .lightGray, cornerRadius: 10)
        button.setImage(.minus, for: .normal)
        button.isEnabled = false
        return button
    }()
        
    private let incrementButton = {
        let button = UIButton(backColor: #colorLiteral(red: 0.8187198043, green: 0.9357115626, blue: 0.731353581, alpha: 1), cornerRadius: 10)
        button.setImage(.plus, for: .normal)
        return button
    }()
    
    private let currentValueLabel = UILabel(
        text: "1",
        font: .systemFont(ofSize: 30, weight: .bold),
        alignment: .center)
    
    private(set) var value = 1 {
        didSet {
            currentValueLabel.text = String(value)
            sendActions(for: .valueChanged)
        }
    }
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        
        decrementButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
        
    private func activateDecrement() {
        decrementButton.isEnabled = true
        decrementButton.backgroundColor = #colorLiteral(red: 0.8187198043, green: 0.9357115626, blue: 0.731353581, alpha: 1)
    }
    
    private func deactivateDecrement() {
        decrementButton.isEnabled = false
        decrementButton.backgroundColor = .lightGray
    }
    
    @objc private func decrementTapped() {
        if value == 2 {
            value -= 1
            deactivateDecrement()
        } else if value > 2 {
            value -= 1
        }
    }
    
    @objc private func incrementTapped() {
        activateDecrement()
        value += 1
    }
}


// MARK: Setup constraints

extension StepperView {
    
    private func setupConstraints() {
        let stack = UIStackView(
            arrangedSubviews: [decrementButton, currentValueLabel, incrementButton],
            spacing: 5,
            distribution: .equalSpacing)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            stack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            decrementButton.heightAnchor.constraint(equalTo: currentValueLabel.heightAnchor),
            decrementButton.widthAnchor.constraint(equalTo: decrementButton.heightAnchor),
            incrementButton.heightAnchor.constraint(equalTo: currentValueLabel.heightAnchor),
            incrementButton.widthAnchor.constraint(equalTo: incrementButton.heightAnchor),
            
            currentValueLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
