import UIKit

class DetailVC<View: DetailView>: BaseViewController<View> {
    
    var goBack: VoidClosure?
    
    // MARK: Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
    }
}
