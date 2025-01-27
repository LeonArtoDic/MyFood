import UIKit

class DetailVC<View: DetailView>: BaseViewController<View> {
    
    var complition: VoidClosure?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Detail"
    }
}
