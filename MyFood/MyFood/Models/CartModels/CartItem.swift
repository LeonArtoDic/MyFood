import UIKit

enum CartItem: Hashable {
    case product(Product)
    case summary(Int)
}

struct Product: Hashable {
    let id: Int
    let title: String
    let price: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
