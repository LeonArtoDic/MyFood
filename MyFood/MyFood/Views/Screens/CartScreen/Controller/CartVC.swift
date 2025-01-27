import UIKit

class CartVC<View: CartView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Cart"
    }
}
