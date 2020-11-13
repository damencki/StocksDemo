import UIKit

/// Builder creates modules with views and presenters for screens
class ModulesBuilder {
    static func createStockListModule() -> UIViewController {
        let view = StockListViewController()
        let presenter = StockListPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
