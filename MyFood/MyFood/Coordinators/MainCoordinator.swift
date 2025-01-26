import UIKit

class MainCoordinator: BaseCoordinator {
    var finishFlow: VoidClosure?
    
    // MARK: Private properties
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    
    // MARK: Initialization
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showMenu()
    }
    
    
    // MARK: Private methods
    
    private func showMenu() {
        let menuList = screenFactory.makeMenuScreen()
        
        menuList.complition = {[weak self] in
            self?.showDishes()
        }
        router.setRootModule(menuList, hideBar: false)
    }
    
    private func showDishes() {
        let dishesList = screenFactory.makeCategoryDishesScreen()
        
        dishesList.complition = {
            
        }
        router.setRootModule(dishesList, hideBar: false)
    }
    
    private func showOrder() {
        let orderVC = screenFactory.makeOrderScreen()
        
        orderVC.complition = {
            
        }
        router.setRootModule(orderVC, hideBar: false)
    }
    
    private func showBasket() {
        let basketVC = screenFactory.makeBasketScreen()
        
        basketVC.complition = {
            
        }
        router.setRootModule(basketVC, hideBar: false)
    }
}
