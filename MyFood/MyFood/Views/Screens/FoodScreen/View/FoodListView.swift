import UIKit

protocol FoodListView: UIView {
    var tableView: UITableView { get }
    var isSearching: Bool { get set }
    var foodData: [FoodItem] { get set }
    var filteredFoodData: [FoodItem] { get set }
    
    func reloadDiffData()
}

class FoodListViewImpl: UIView, FoodListView {
    
    // MARK: - Public properties
    
    let tableView = UITableView()
    
    var foodData = FoodMockData()()
    var filteredFoodData = [FoodItem]()
    
    var isSearching = false
    
    
    // MARK: - Private properties
    
    typealias FoodSnapshot = NSDiffableDataSourceSnapshot<FoodSection, FoodItem>
    typealias FoodDataSource = UITableViewDiffableDataSource<FoodSection, FoodItem>
    private var diffableDataSource: FoodDataSource?
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        registerCell()
        createDataSource()
        reloadDiffData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    
    // MARK: - Public methods
    
    func reloadDiffData() {
        var snapshot = FoodSnapshot()
        snapshot.appendSections([.sectionFood])
        
        isSearching
        ? snapshot.appendItems(filteredFoodData, toSection: .sectionFood)
        : snapshot.appendItems(foodData, toSection: .sectionFood)
    
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Private methods
    
    private func setupTableView() {
        tableView.frame = self.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white

        addSubview(tableView)
    }
    
    private func registerCell() {
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseId)
    }
    
    private func createDataSource(){
        diffableDataSource = FoodDataSource(tableView: tableView) { tableView, indexPath, item in
            guard let section = FoodSection(rawValue: indexPath.section) else { return nil }
        
            switch section {
            case .sectionFood:
                let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseId, for: indexPath) as? FoodCell
                cell?.setupData(item)
                
                return cell
            }
        }
    }
}
