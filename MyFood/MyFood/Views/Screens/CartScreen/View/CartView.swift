import UIKit

protocol CartViewLogic: UIView {
    var tableView: UITableView { get }
    var placeOrderButton: UIButton { get }
    var data: [Order] { get set }
    
    func reloadDiffData()
}

class CartView: UIView, CartViewLogic {
    
    // MARK: - Public properties
    
    var tableView = UITableView()
    var placeOrderButton = UIButton()
    
    var orderManager = OrderManager.shared
    
    var data = [Order]() {
        didSet {
            if data.isEmpty {
                tableView.isHidden = true
                placeOrderButton.isHidden = true
                emptyCartImageView.isHidden = false
            }
        }
    }
    
    // MARK: - Private properties
    
    private let emptyCartImageView = {
        let imageVi = UIImageView(image: .emptyCart)
        imageVi.contentMode = .scaleAspectFit
        return imageVi
    }()
    
    typealias CartSnapshot = NSDiffableDataSourceSnapshot<CartSection, CartItem>
    typealias CartDataSource = UITableViewDiffableDataSource<CartSection, CartItem>
    private var diffData: CartDataSource?
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.separatorStyle = .none
                
        if let data = orderManager.getTotalOrder() {
            self.data = data
            
            emptyCartImageView.isHidden = true
            
            registerCell()
            createDataSource()
            reloadDiffData()
            configureOrderButton()
            setupConstraints()
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(emptyCartImageView)
        emptyCartImageView.frame = CGRect(x: 0, y: 0, width: bounds.width / 3, height: bounds.width / 3)
        emptyCartImageView.center = center
    }
    
    
    // MARK: - Public methods
    
    func reloadDiffData() {
        let totalCost = data.reduce(0) { $0 + ($1.price * Double($1.count))}
        var snapshot = NSDiffableDataSourceSnapshot<CartSection, CartItem>()
        snapshot.appendSections([.products, .summary])
        snapshot.appendItems(data.map { .product($0) }, toSection: .products)
        snapshot.appendItems([.summary(totalCost)], toSection: .summary)
        diffData?.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Private methods
    
    private func registerCell() {
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
        tableView.register(TotalCostCell.self, forCellReuseIdentifier: TotalCostCell.reuseId)
    }
    
    private func createDataSource(){
        diffData = UITableViewDiffableDataSource<CartSection, CartItem>(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .product(let order):
                let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as? CartCell
                cell?.setupData(order)
                return cell
            case .summary(let total):
                let cell = tableView.dequeueReusableCell(withIdentifier: TotalCostCell.reuseId, for: indexPath) as? TotalCostCell
                cell?.setupData(total)
                return cell
            }
        }
    }
    
    private func configureOrderButton() {
        var configure = UIButton.Configuration.filled()
        
        configure.title = "PLACE ORDER"
        configure.cornerStyle = .small
        configure.baseBackgroundColor = #colorLiteral(red: 0.0505053103, green: 0.1062033251, blue: 0.1656947136, alpha: 1)
        
        placeOrderButton = UIButton(configuration: configure)
    }
}


// MARK: Setup constraints

extension CartView {
    
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
