import UIKit

final class Di {
    
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactory
    fileprivate let networService: NetworkService
    
    fileprivate var foodProvider: FoodProvider {
        FoodProvider(networkService: networService)
    }
    
    init() {
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        networService = NetworkService()
                
        screenFactory.di = self
    }
}


// MARK: App coordinator factory

protocol AppFactoryLogic {
    func makeKeyWindowWithCoordinator() -> (UIWindow, CoordinatorLogic)
}

extension Di: AppFactoryLogic {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, CoordinatorLogic) {
        let window = UIWindow()
        let rootVC = createNavigationController()
        let router = Router(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
    func createNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        appearance.setBackIndicatorImage(
            .back,
            transitionMaskImage: .back
        )
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]

        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        return navController
    }
}


// MARK: Screen factory

protocol ScreenFactoryLogic {
    func makeMenuScreen() -> CategoryListVC<CategoryListView>
    func makeFoodScreen() -> FoodListVC<FoodListView>
    func makeDetailScreen() -> DetailVC<DetailView>
    func makeCartScreen() -> CartVC<CartView>
}

final class ScreenFactory: ScreenFactoryLogic {
    
    fileprivate weak var di: Di!
    fileprivate init(){}
    
    func makeMenuScreen() -> CategoryListVC<CategoryListView> {
        CategoryListVC<CategoryListView>()
    }
    
    func makeFoodScreen() -> FoodListVC<FoodListView> {
        FoodListVC<FoodListView>(foodProvider: di.foodProvider)
    }
    
    func makeDetailScreen() -> DetailVC<DetailView> {
        DetailVC<DetailView>()
    }
    
    func makeCartScreen() -> CartVC<CartView> {
        CartVC<CartView>()
    }
}


// MARK: Coordinator factory

protocol CoordinatorFactoryLogic {
    func makeApplicationCoordinator(router: Router) -> AppCoordinator
    func makeMainCoordinator(router: Router) -> MainCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryLogic {
    
    private let screenFactory: ScreenFactoryLogic
    
    fileprivate init(screenFactory: ScreenFactoryLogic){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> AppCoordinator {
        AppCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeMainCoordinator(router: Router) -> MainCoordinator {
        MainCoordinator(router: router, screenFactory: screenFactory as! ScreenFactory)
    }
}
