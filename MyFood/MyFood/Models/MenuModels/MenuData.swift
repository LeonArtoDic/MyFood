import UIKit

class MenuData {
    func callAsFunction() -> [CategoryItem] {
        [
            CategoryItem(title: "BBQs", image: UIImage(resource: .bbq), id: .bbqs),
            CategoryItem(title: "Best-foods", image: UIImage(resource: .best), id: .bestFoods),
            CategoryItem(title: "Breads", image: UIImage(resource: .breads), id: .breads),
            CategoryItem(title: "Burgers", image: UIImage(resource: .burgers), id: .burgers),
            CategoryItem(title: "Chocolates", image: UIImage(resource: .chocolates), id: .chocolates),
            CategoryItem(title: "Desserts", image: UIImage(resource: .desserts), id: .desserts),
            CategoryItem(title: "Drinks", image: UIImage(resource: .drinks), id: .drinks),
            CategoryItem(title: "Fried-chicken", image: UIImage(resource: .chicken), id: .chicken),
            CategoryItem(title: "Ice-cream", image: UIImage(resource: .iceCream), id: .iceCream),
            CategoryItem(title: "Pizzas", image: UIImage(resource: .pizza), id: .pizzas),
            CategoryItem(title: "Porks", image: UIImage(resource: .pork), id: .porks),
            CategoryItem(title: "Sandwiches", image: UIImage(resource: .sandwiches), id: .sandwiches),
            CategoryItem(title: "Sausages", image: UIImage(resource: .sausages), id: .sausages),
            CategoryItem(title: "Steaks", image: UIImage(resource: .steaks), id: .steaks)
        ]
    }
}
