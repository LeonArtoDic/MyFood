import UIKit

struct CategoryItem: Hashable {
    public let title: String
    public let imageString: UIImage
    public let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CategoryItem, rhs: CategoryItem) -> Bool {
        return lhs.id == rhs.id
    }
}
