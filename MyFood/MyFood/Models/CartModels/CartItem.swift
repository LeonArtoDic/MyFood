import UIKit

enum CartItem: Hashable {
    case product(Order)
    case summary(Double)
}

struct Order: Hashable, Decodable, Encodable {
    let id: String
    let title: String
    let price: Double
    let imageString: String
    let count: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
}
