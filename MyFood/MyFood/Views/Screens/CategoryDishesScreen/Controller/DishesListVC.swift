import UIKit

class DishesListVC<View: DishesListView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Dishes"
        
        navigationItem.sea
    }
}
