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
            self?.showFood()
        }
        
        menuList.goToCart = {[weak self] in
            self?.showCart()
        }
        
        router.setRootModule(menuList, hideBar: false)
    }
    
    private func showFood() {
        let foodList = screenFactory.makeFoodScreen()
        
        foodList.goBack = { [weak self] in
            self?.router.popModule(animated: true)
        }
        
        foodList.goToDetail = { [weak self] in
            self?.showDetail()
        }
        
        router.push(foodList)
    }
    
    private func showDetail() {
        let detailVC = screenFactory.makeDetailScreen()
        
        detailVC.goBack = {[weak self] in
            self?.router.popModule(animated: true)
        }
        
        router.push(detailVC)
    }
    
    private func showCart() {
        let cartVC = screenFactory.makeCartScreen()
        
        cartVC.complition = {
            
        }
        
        router.setRootModule(cartVC, hideBar: false)
    }
}
