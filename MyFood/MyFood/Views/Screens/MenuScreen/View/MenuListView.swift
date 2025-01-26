import UIKit

protocol MenuListView: UIView {
    var collectionView: UICollectionView! { get }
}

final class MenuListViewImpl: UIView, MenuListView {
    
    var collectionView: UICollectionView!
    
    typealias CategorySnapshot = NSDiffableDataSourceSnapshot<CategorySection, CategoryItem>
    typealias CategoryDataSource = UICollectionViewDiffableDataSource<CategorySection, CategoryItem>
    
    private var diffableDataSource: CategoryDataSource?
    
    let mockData = [
        CategoryItem(title: "One", imageString: UIImage(resource: .foodOne), id: 0),
        CategoryItem(title: "Two", imageString: UIImage(resource: .foodTwo), id: 1),
        CategoryItem(title: "Three", imageString: UIImage(resource: .foodThree), id: 2),
        CategoryItem(title: "Four", imageString: UIImage(resource: .foodFour), id: 3),
        CategoryItem(title: "Five", imageString: UIImage(resource: .foodFive), id: 4),
        CategoryItem(title: "Six", imageString: UIImage(resource: .foodSix), id: 5),
        CategoryItem(title: "Seven", imageString: UIImage(resource: .foodSeven), id: 6),
        CategoryItem(title: "Eight", imageString: UIImage(resource: .foodEight), id: 7),
        CategoryItem(title: "Nine", imageString: UIImage(resource: .foodNine), id: 8),
        CategoryItem(title: "Ten", imageString: UIImage(resource: .foodTen), id: 9),
        CategoryItem(title: "Eleven", imageString: UIImage(resource: .foodEleven), id: 10),
        CategoryItem(title: "Twelve", imageString: UIImage(resource: .foodTwelwe), id: 11)
    ]
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        registerCell()
        createDataSource()
        reloadDiffData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private methods
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white

        self.addSubview(collectionView)
    }
    
    private func registerCell() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
    }
    
    private func createDataSource(){
        diffableDataSource = CategoryDataSource(collectionView: collectionView) { collectionView, indexPath, Item in
            guard let section = CategorySection(rawValue: indexPath.section) else { return nil }
        
            switch section {
            case .sectionCategory:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell
                cell?.data = Item
                
                return cell
            }
        }
    }
    
    private func reloadDiffData() {
        var snapshot = CategorySnapshot()
        snapshot.appendSections([.sectionCategory])
        snapshot.appendItems(mockData, toSection: .sectionCategory)
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}
