import UIKit

struct FoodItem: Hashable {
    public let title: String
    public let rating: Int
    public let description: String
    public let price: Double
    public let imageString: String
    public let id: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.id == rhs.id
    }
}
