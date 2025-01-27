import UIKit

public struct CategoryItem: Hashable {
    public let title: String
    public let imageString: UIImage
    public let id: Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CategoryItem, rhs: CategoryItem) -> Bool {
        return lhs.id == rhs.id
    }
}
