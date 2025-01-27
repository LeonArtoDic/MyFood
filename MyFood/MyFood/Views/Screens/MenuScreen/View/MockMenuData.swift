import UIKit

class MenuMockData {
    func callAsFunction() -> [CategoryItem] {
        [
            CategoryItem(title: "One", imageString: UIImage(resource: .foodOne), id: 0),
            CategoryItem(title: "Two", imageString: UIImage(resource: .foodTwo), id: 1),
            CategoryItem(title: "Three", imageString: UIImage(resource: .foodThree), id: 2),
            CategoryItem(title: "Four", imageString: UIImage(resource: .foodFour), id: 3),
            CategoryItem(title: "Five", imageString: UIImage(resource: .foodFive), id: 4),
            CategoryItem(title: "Six", imageString: UIImage(resource: .foodSix), id: 5),
            CategoryItem(title: "Seven", imageString: UIImage(resource: .foodSeven), id: 6),
            CategoryItem(title: "Eight", imageString: UIImage(resource: .foodEight), id: 7),
            CategoryItem(title: "Nine", imageString: UIImage(resource: .foodNine), id: 8),
            CategoryItem(title: "Ten", imageString: UIImage(resource: .foodTen), id: 9),
            CategoryItem(title: "Eleven", imageString: UIImage(resource: .foodEleven), id: 10),
            CategoryItem(title: "Twelve", imageString: UIImage(resource: .foodTwelwe), id: 11)
        ]
    }
}
