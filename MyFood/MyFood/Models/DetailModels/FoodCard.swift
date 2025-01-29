import UIKit

struct FoodCard: Decodable {
    let id: String
    let img: String
    let name, dsc: String
    let price, rate: Int
    let country: String
}
