import UIKit

protocol CategoryListViewLogic: UIView {
    var collectionView: UICollectionView! { get }
    var data: [CategoryItem] { get }
}

final class CategoryListView: UIView, CategoryListViewLogic {
    
    // MARK: Public properties
    
    var collectionView: UICollectionView!
    var data = MenuData()()
    
    // MARK: Private properties
    
    typealias CategorySnapshot = NSDiffableDataSourceSnapshot<CategorySection, CategoryItem>
    typealias CategoryDataSource = UICollectionViewDiffableDataSource<CategorySection, CategoryItem>
    private var diffData: CategoryDataSource?

    
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
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white

        addSubview(collectionView)
    }
    
    private func registerCell() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
    }
    
    private func createDataSource(){
        diffData = CategoryDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = CategorySection(rawValue: indexPath.section) else { return nil }
        
            switch section {
            case .sectionCategory:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell
                cell?.setupData(item)
                
                return cell
            }
        }
    }
    
    private func reloadDiffData() {
        var snapshot = CategorySnapshot()
        snapshot.appendSections([.sectionCategory])
        snapshot.appendItems(data, toSection: .sectionCategory)
        diffData?.apply(snapshot, animatingDifferences: true)
    }
}
