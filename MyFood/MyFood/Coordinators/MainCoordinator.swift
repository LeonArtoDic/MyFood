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
        
        menuList.goToFood = {[weak self] selectedCategory in
            self?.showFood(selectedCategory)
        }
        
        menuList.goToCart = {[weak self] in
            self?.showCart()
        }
        
        router.setRootModule(menuList, hideBar: false)
    }
    
    private func showFood(_ categoryName: Categories) {
        let foodList = screenFactory.makeFoodScreen()
        
        foodList.category = categoryName
        
        foodList.goBack = { [weak self] in
            self?.router.popModule(animated: true)
        }
        
        foodList.goToDetail = { [weak self] item in
            self?.showDetail(item)
        }
        
        foodList.goToCart = { [weak self] in
            self?.showCart()
        }
        
        router.push(foodList)
    }
    
    private func showDetail(_ item: FoodItem) {
        let detailVC = screenFactory.makeDetailScreen()
        detailVC.item = item
        
        detailVC.goBack = {[weak self] in
            self?.router.popModule(animated: true)
        }
        
        router.push(detailVC)
    }
    
    private func showCart() {
        let cartVC = screenFactory.makeCartScreen()
        
        router.push(cartVC)
    }
}
