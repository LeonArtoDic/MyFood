import UIKit

class CartVC<View: CartViewLogic>: BaseViewController<View>, UITableViewDelegate {
    
    // MARK: - Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cart"
        
        setupNavigationButton()
        setupTargets()
        rootView.tableView.delegate = self
        
    }
    
    
    // MARK: - Private methods
    
    private func setupTargets() {
        rootView.placeOrderButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
    }
    
    private func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .delete, style: .done, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc private func rightButtonTapped() {
        OrderManager.shared.removeAll()
        rootView.data.removeAll()
    }
    
    @objc private func placeOrder() {
        let totalCost = rootView.data.reduce(0) { $0 + ($1.price * Double($1.count))}
        let alert = UIAlertController(title: "Success!",
                                      message: "Total: $\(totalCost)",
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
    
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard 
            let section = CartSection(rawValue: indexPath.section),
            section == .products
        else { return nil }
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self else { return }
            
            let deletedOrder = self.rootView.data.remove(at: indexPath.row)
            
            OrderManager.shared.remove(at: deletedOrder.id)
            self.rootView.reloadDiffData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
