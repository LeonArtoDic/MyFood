import UIKit

class BasketVC<View: BasketView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Basket"
    }
}
