import UIKit

class DetailVC<View: DetailView>: BaseViewController<View> {
    
    var goBack: VoidClosure?
    
    // MARK: Life cycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
        
        setupLeftBarButton()
    }
    
    
    // MARK: Private methods
    
    private func setupLeftBarButton() {
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = "goBack"
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 17)
            outgoing.foregroundColor = UIColor.black
            
            return outgoing
          }
        
        configuration.image = .back
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -8, bottom: 0, trailing: 0)
        
        let action = UIAction { [weak self] _ in
            print("<-- goBack tapped")
            self?.goBack?()
        }
        
        let backButton = UIButton(configuration: configuration, primaryAction: action)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
}
