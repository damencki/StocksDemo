import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let stockListModule = ModulesBuilder.createStockListModule(stocksService: StocksService())
        window?.rootViewController = UINavigationController(rootViewController: stockListModule)
        window?.makeKeyAndVisible()
        return true
    }
}

