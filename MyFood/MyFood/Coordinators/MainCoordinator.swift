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
        let dishesList = screenFactory.makeFoodScreen()
        
        dishesList.complition = { [weak self] in
            self?.router.popModule(animated: true)
        }
        router.push(dishesList, animated: true)
    }
    
    private func showDetail() {
        let detailVC = screenFactory.makeDetailScreen()
        
        detailVC.complition = {
            
        }
        router.setRootModule(detailVC, hideBar: false)
    }
    
    private func showCart() {
        let cartVC = screenFactory.makeCartScreen()
        
        cartVC.complition = {
            
        }
        router.setRootModule(cartVC, hideBar: false)
    }
}
