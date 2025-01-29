import UIKit

class DetailVC<View: DetailView>: BaseViewController<View> {
    
    var goBack: VoidClosure?
    
    
    // MARK: Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
        
        setupNavigationButton()
    }
    
    
    // MARK: Private methods
    
    private func setupNavigationButton() {
        let backButton = BackBarButtonView()
        backButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func leftButtonTapped() {
        print("<-- goBack tapped")
        goBack?()
    }

}
