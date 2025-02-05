import Foundation

struct FoodCardElement: Decodable {
    let id: String
    let img: String
    let name, dsc: String
    let rate: Int
    let price: Double
}

typealias FoodCards = [FoodCardElement]
