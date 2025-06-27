enum Categories {
    case bbqs
    case bestFoods
    case breads
    case burgers
    case chocolates
    case desserts
    case drinks
    case chicken
    case iceCream
    case pizzas
    case porks
    case sandwiches
    case sausages
    case steaks
    
    var url: String {
        switch self {
        case .bbqs:
            "https://free-food-menus-api-two.vercel.app/bbqs"
        case .bestFoods:
            "https://free-food-menus-api-two.vercel.app/best-foods"
        case .breads:
            "https://free-food-menus-api-two.vercel.app/breads"
        case .burgers:
            "https://free-food-menus-api-two.vercel.app/burgers"
        case .chocolates:
            "https://free-food-menus-api-two.vercel.app/chocolates"
        case .desserts:
            "https://free-food-menus-api-two.vercel.app/desserts"
        case .drinks:
            "https://free-food-menus-api-two.vercel.app/drinks"
        case .chicken:
            "https://free-food-menus-api-two.vercel.app/fried-chicken"
        case .iceCream:
            "https://free-food-menus-api-two.vercel.app/ice-cream"
        case .pizzas:
            "https://free-food-menus-api-two.vercel.app/pizzas"
        case .porks:
            "https://free-food-menus-api-two.vercel.app/porks"
        case .sandwiches:
            "https://free-food-menus-api-two.vercel.app/sandwiches"
        case .sausages:
            "https://free-food-menus-api-two.vercel.app/sausages"
        case .steaks:
            "https://free-food-menus-api-two.vercel.app/steaks"
        }
    }
}
