import UIKit

protocol FoodListViewLogic: UIView {
    var tableView: UITableView { get }
    var isSearching: Bool { get set }
    var data: [FoodItem] { get set }
    var filteredFoodData: [FoodItem] { get set }
    
    func reloadDiffData()
}

final class FoodListView: UIView, FoodListViewLogic {
    
    // MARK: - Public properties
    
    let tableView = UITableView()
    
    var data = [FoodItem]()
    var filteredFoodData = [FoodItem]()
    
    var isSearching = false
    
    
    // MARK: - Private properties
    
    typealias FoodSnapshot = NSDiffableDataSourceSnapshot<FoodSection, FoodItem>
    typealias FoodDataSource = UITableViewDiffableDataSource<FoodSection, FoodItem>
    private var diffData: FoodDataSource?
    
    
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
        : snapshot.appendItems(data, toSection: .sectionFood)
    
        diffData?.apply(snapshot, animatingDifferences: true)
    }
    
    
    // MARK: - Private methods
    
    private func setupTableView() {
        tableView.frame = bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        addSubview(tableView)
    }
    
    private func registerCell() {
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseId)
    }
    
    private func createDataSource(){
        diffData = FoodDataSource(tableView: tableView) { tableView, indexPath, item in
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
