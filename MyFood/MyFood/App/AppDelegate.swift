import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appFactory: AppFactory = Di()
    private var appCoordinator: Coordinator?

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
            
        self.window?.makeKeyAndVisible()
        coordinator.start()
        
        return true
    }
}

