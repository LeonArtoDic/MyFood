import UIKit

final class Di {
    
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    
    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        
        screenFactory.di = self
    }
}


// MARK: App coordinator factory

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = createNavigationController()
        let router = RouterImp(rootController: rootVC)
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

protocol ScreenFactory {
    func makeMenuScreen() -> MenuListViewController<MenuListViewImpl>
    func makeFoodScreen() -> FoodListVC<FoodListViewImpl>
    func makeDetailScreen() -> DetailVC<DetailViewImpl>
    func makeCartScreen() -> CartVC<CartViewImpl>
}

final class ScreenFactoryImpl: ScreenFactory {
    
    fileprivate weak var di: Di!
    fileprivate init(){}
    
    func makeMenuScreen() -> MenuListViewController<MenuListViewImpl> {
        MenuListViewController<MenuListViewImpl>()
    }
    
    func makeFoodScreen() -> FoodListVC<FoodListViewImpl> {
        FoodListVC<FoodListViewImpl>()
    }
    
    func makeDetailScreen() -> DetailVC<DetailViewImpl> {
        DetailVC<DetailViewImpl>()
    }
    
    func makeCartScreen() -> CartVC<CartViewImpl> {
        CartVC<CartViewImpl>()
    }
}


// MARK: Coordinator factory

protocol CoordinatorFactory {
    func makeApplicationCoordinator(router: Router) -> AppCoordinator
    func makeMainCoordinator(router: Router) -> MainCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> AppCoordinator {
        AppCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeMainCoordinator(router: Router) -> MainCoordinator {
        MainCoordinator(router: router, screenFactory: screenFactory)
    }
}
