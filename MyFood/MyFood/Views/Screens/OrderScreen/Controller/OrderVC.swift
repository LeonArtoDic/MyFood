import UIKit

class OrderVC<View: OrderView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Order"
    }
}
