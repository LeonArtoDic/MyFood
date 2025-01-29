import UIKit

class FoodListVC<View: FoodListView>: BaseViewController<View>, UITableViewDelegate, UISearchBarDelegate {
    
    var goBack: VoidClosure?
    var goToCart: VoidClosure?
    var goToDetail: VoidClosure?
    
    // MARK: - Private properties
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter..."
        return searchBar
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        rootView.tableView.delegate = self
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        setupNavigationButton()
    }
    
    
    // MARK: - Private methods
    
    private func setupNavigationButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .back, style: .done, target: self, action: #selector(leftButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .cart, style: .done, target: self, action: #selector(rightButtonTapped))
    }
    
    @objc private func leftButtonTapped() {
        print("LeftButtonTapped")
        goBack?()
    }
    
    @objc private func rightButtonTapped() {
        print("RightButtonTapped")
        goToCart?()
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped cell - ", indexPath)
        goToDetail?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Enter ->", searchText)
        if !searchText.isEmpty {
            rootView.isSearching = true
            rootView.filteredFoodData = rootView.foodData.filter {$0.title.lowercased().contains(searchText.lowercased()) }
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
