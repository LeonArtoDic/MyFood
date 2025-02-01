import UIKit

protocol CartView: UIView {
    var tableView: UITableView { get }
}

class CartViewImpl: UIView, CartView {
    
    // MARK: - Public properties
    
    var tableView = UITableView()
    
    var cartData = CartMockData()()
    
    
    // MARK: - Private properties
    
    private var placeOrderButton = UIButton()
    
    typealias CartSnapshot = NSDiffableDataSourceSnapshot<CartSection, CartItem>
    typealias CartDataSource = UITableViewDiffableDataSource<CartSection, CartItem>
    private var diffableDataSource: CartDataSource?
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
        createDataSource()
        reloadDiffData()
        configureOrderButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    // MARK: - Private methods
    
    private func registerCell() {
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
        tableView.register(TotalCostCell.self, forCellReuseIdentifier: TotalCostCell.reuseId)
    }
    
    private func createDataSource(){
        diffableDataSource = UITableViewDiffableDataSource<CartSection, CartItem>(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .product(let product):
                let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as? CartCell
                cell?.setupData(product)
                return cell
            case .summary(let total):
                let cell = tableView.dequeueReusableCell(withIdentifier: TotalCostCell.reuseId, for: indexPath) as? TotalCostCell
                cell?.setupData(total)
                return cell
            }
        }
    }
    
    private func reloadDiffData() {
        let totalCost = cartData.reduce(0) { $0 + $1.price }
        var snapshot = NSDiffableDataSourceSnapshot<CartSection, CartItem>()
        snapshot.appendSections([.products, .summary])
        snapshot.appendItems(cartData.map { .product($0) }, toSection: .products)
        snapshot.appendItems([.summary(totalCost)], toSection: .summary)
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureOrderButton() {
        var configure = UIButton.Configuration.filled()
        
        configure.title = "PLACE ORDER"
        configure.cornerStyle = .small
        configure.baseBackgroundColor = .orange
        
        let action = UIAction {_ in
            print("-- PLACE ORDER tapped --")
        }
        
        placeOrderButton = UIButton(configuration: configure, primaryAction: action)
    }
}


// MARK: Setup constraints

extension CartViewImpl {
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        placeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
        addSubview(placeOrderButton)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: placeOrderButton.topAnchor, constant: -10),
            
            placeOrderButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            placeOrderButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            placeOrderButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
