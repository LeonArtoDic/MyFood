import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appFactory: AppFactoryLogic = Di()
    private var appCoordinator: CoordinatorLogic?

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
            
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        coordinator.start()
        
        return true
    }
}

