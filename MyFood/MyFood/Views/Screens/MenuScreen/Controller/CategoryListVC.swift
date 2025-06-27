import UIKit

final class CategoryListVC<View: CategoryListViewLogic>: BaseViewController<View>, UICollectionViewDelegateFlowLayout {
    
    // MARK: Navigation
    
    var goToFood: ((Categories) -> Void)?
    var goToCart: VoidClosure?
    
    // MARK: Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Menu"

        setupRightButton()
        rootView.collectionView.delegate = self
    }
    
    
    // MARK: Private methods
    
    private func setupRightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .cart, style: .done, target: self, action: #selector(rightButtonTapped))
    }
    
    @objc private func rightButtonTapped() {
        goToCart?()
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 45) / 2
        let height = width - 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToFood?(rootView.data[indexPath.row].id)
    }
}
