import UIKit

final class DetailVC<View: DetailViewLogic>: BaseViewController<View> {
    
    // MARK: Navigation
    
    var goBack: VoidClosure?
    
    // MARK: Public properties
    
    var item: FoodItem?
    
    
    // MARK: Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        rootView.data = item
        setupTargets()
        setupNavigationButton()
    }
    
    
    // MARK: - Private methods
    
    private func setupTargets() {
        rootView.stepperView.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        rootView.addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
    }
    
    private func setupNavigationButton() {
        let image = UIImage(systemName: "heart.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(saveToFavorites))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
    
    @objc private func saveToFavorites() {
        let alert = UIAlertController(title: "Added to favorites", 
                                      message: nil,
                                      preferredStyle: .alert)

        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func stepperChanged() {
        guard let item else { return }
        
        guard rootView.stepperView.value > 0 else {
            OrderManager.shared.remove(at: item.id)
            return
        }

        let order = Order(
            id: item.id,
            title: item.title,
            price: item.price,
            imageString: item.imageString,
            count: rootView.stepperView.value
        )
        
        OrderManager.shared.saveOrder(order)
    }
    
    @objc private func addToCartTapped() {
        guard let item else { return }
        
        rootView.addToCartButton.isHidden = true
        rootView.stepperView.isHidden = false
        rootView.stepperView.value = 1
        
        let order = Order(
            id: item.id,
            title: item.title,
            price: item.price,
            imageString: item.imageString,
            count: rootView.stepperView.value
        )
        
        OrderManager.shared.saveOrder(order)
    }
}
