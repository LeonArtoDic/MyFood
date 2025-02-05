import UIKit

final class FoodListVC<View: FoodListViewLogic>: BaseViewController<View>, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: Navigation
    
    var goBack: VoidClosure?
    var goToCart: VoidClosure?
    var goToDetail: ((FoodItem) -> Void)?
    
    // MARK: - Public properties
    
    var category: Categories?
    
    // MARK: - Private properties
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter..."
        return searchBar
    }()
    
    private let foodProvider: FoodProvider
    
    
    // MARK: Initialization
    
    init(foodProvider: FoodProvider) {
        self.foodProvider = foodProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        rootView.tableView.delegate = self
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        Task {
            self.rootView.data = await foodProvider.getFoodList(by: category ?? .bbqs)
            self.rootView.reloadDiffData()
        }

        setupNavigationButton()
    }
    
    
    // MARK: - Private methods
    
    private func setupNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .back, style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .cart, style: .done, target: self, action: #selector(rightButtonTapped))
        navigationItem.backButtonTitle = "Food"
    }
    
    @objc private func leftButtonTapped() {
        goBack?()
    }
    
    @objc private func rightButtonTapped() {
        goToCart?()
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rootView.isSearching
        ? goToDetail?(rootView.filteredFoodData[indexPath.row])
        : goToDetail?(rootView.data[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            rootView.isSearching = true
            rootView.filteredFoodData = rootView.data.filter {$0.title.lowercased().contains(searchText.lowercased()) }
            rootView.reloadDiffData()
        } else {
            rootView.isSearching = false
            rootView.reloadDiffData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        rootView.isSearching = false
        rootView.reloadDiffData()
    }
}
