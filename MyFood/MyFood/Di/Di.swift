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
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        return navController
    }
}

protocol ScreenFactory {
    func makeMenuScreen() -> MenuListViewController<MenuListViewImpl>
    func makeCategoryDishesScreen() -> DishesListVC<DishesListViewImpl>
    func makeOrderScreen() -> OrderVC<OrderViewImpl>
    func makeBasketScreen() -> BasketVC<BasketViewImpl>
}

final class ScreenFactoryImpl: ScreenFactory {
    
    fileprivate weak var di: Di!
    fileprivate init(){}
    
    func makeMenuScreen() -> MenuListViewController<MenuListViewImpl> {
        MenuListViewController<MenuListViewImpl>()
    }
    
    func makeCategoryDishesScreen() -> DishesListVC<DishesListViewImpl> {
        DishesListVC<DishesListViewImpl>()
    }
    
    func makeOrderScreen() -> OrderVC<OrderViewImpl> {
        OrderVC<OrderViewImpl>()
    }
    
    func makeBasketScreen() -> BasketVC<BasketViewImpl> {
        BasketVC<BasketViewImpl>()
    }
}

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
