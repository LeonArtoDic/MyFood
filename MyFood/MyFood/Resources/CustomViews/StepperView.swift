import UIKit

final class StepperView: UIControl {
    
    // MARK: Public properties
    
    var value = 0 {
        didSet {
            currentValueLabel.text = String(value)
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: Private properties
    
    private let decrementButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.setImage(.minus, for: .normal)
        return button
    }()
        
    private let incrementButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.setImage(.plus, for: .normal)
        return button
    }()
    
    private let currentValueLabel = UILabel(
        font: .systemFont(ofSize: 25, weight: .bold),
        alignment: .center)
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9577004313, green: 0.9528433681, blue: 0.9485501647, alpha: 1)
        layer.cornerRadius = 10
        
        setupConstraints()
        
        decrementButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
    
    @objc private func decrementTapped() {
        value -= 1
    }
    
    @objc private func incrementTapped() {
        value += 1
    }
}


// MARK: Setup constraints

extension StepperView {
    
    private func setupConstraints() {
        decrementButton.translatesAutoresizingMaskIntoConstraints = false
        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(decrementButton)
        addSubview(incrementButton)
        addSubview(currentValueLabel)
        
        NSLayoutConstraint.activate([
            decrementButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            decrementButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            decrementButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            decrementButton.widthAnchor.constraint(equalTo: decrementButton.heightAnchor),

            incrementButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            incrementButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            incrementButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            incrementButton.widthAnchor.constraint(equalTo: incrementButton.heightAnchor),
      
            currentValueLabel.topAnchor.constraint(equalTo: topAnchor),
            currentValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            currentValueLabel.widthAnchor.constraint(equalToConstant: 100),
            currentValueLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
