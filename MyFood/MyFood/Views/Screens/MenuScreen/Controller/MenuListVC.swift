import UIKit

class MenuListVC<View: MenuListView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Menu"
        
        let action = UIAction { [weak self] _ in
            self?.complition?()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: action)
    }
}
