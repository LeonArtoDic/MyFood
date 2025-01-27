import UIKit

final class MenuListViewController<View: MenuListView>: BaseViewController<View>, UICollectionViewDelegateFlowLayout {
    
    var complition: VoidClosure?
    
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
        print("RightButtonTapped")
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 45) / 2
        let height = width - 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped item at \(indexPath.row)")
        complition?()
    }
}
