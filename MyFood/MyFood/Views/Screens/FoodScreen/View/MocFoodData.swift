import UIKit

class FoodMockData {
    func callAsFunction() -> [FoodItem] {
        [
            FoodItem(title: "One", rating: "5", description: "For example, “The mashed potatoes were creamy and rich, with a smooth texture that made every bite satisfying,” gives a clearer picture than just saying, “The mashed potatoes were tasty.”", price: "100$", imageString: UIImage(resource: .foodOne), id: 0),
            FoodItem(title: "Two", rating: "1", description: "Description", price: "100$", imageString: UIImage(resource: .foodTwo), id: 1),
            FoodItem(title: "Three", rating: "0.5", description: "Description", price: "100$", imageString: UIImage(resource: .foodThree), id: 2),
            FoodItem(title: "Four", rating: "3.3", description: "Description", price: "100$", imageString: UIImage(resource: .foodFour), id: 3),
            FoodItem(title: "Five", rating: "2", description: "Description", price: "100$", imageString: UIImage(resource: .foodFive), id: 4),
            FoodItem(title: "Six", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodSix), id: 5),
            FoodItem(title: "Seven", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodSeven), id: 6),
            FoodItem(title: "Eight", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodEight), id: 7),
            FoodItem(title: "Nine", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodNine), id: 8),
            FoodItem(title: "Ten", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodTen), id: 9),
            FoodItem(title: "Eleven", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodEleven), id: 10),
            FoodItem(title: "Twelwe", rating: "5", description: "Description", price: "100$", imageString: UIImage(resource: .foodTwelwe), id: 11),
        ]
    }
}
