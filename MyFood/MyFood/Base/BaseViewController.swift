import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var rootView: View { view as! View }
    var onBackButtonTap: OnBackButtonTap?
    
    override func loadView() {
        view = View()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            print("<--- Moved back")
            onBackButtonTap?()
        }
    }
}
