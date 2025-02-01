import UIKit

struct FoodItem: Hashable {
    public let title: String
    public let rating: String
    public let description: String
    public let price: String
    public let imageString: UIImage
    public let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.id == rhs.id
    }
}
