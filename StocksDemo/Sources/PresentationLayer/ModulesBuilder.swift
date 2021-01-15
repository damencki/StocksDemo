import UIKit

protocol ModulesBuilderProtocol {
    static func createStockListModule(stocksService: StocksServiceProtocol) -> UIViewController
    static func createStockDetailsModule(stock: Stock, stocksService: StocksServiceProtocol) -> UIViewController
}

/// Builder creates modules with views and presenters for screens
class ModulesBuilder: ModulesBuilderProtocol {
    static func createStockListModule(stocksService: StocksServiceProtocol) -> UIViewController {
        let view = StockListViewController()
        let presenter = StockListPresenter(view: view, stocksService: stocksService)
        view.presenter = presenter
        return view
    }
    
    static func createStockDetailsModule(stock: Stock, stocksService: StocksServiceProtocol) -> UIViewController {
        let view = StockDetailsViewController()
        let presenter = StockDetailsPresenter(view: view,
                                              stock: stock,
                                              stockService: stocksService)
        view.presenter = presenter
        return view
    }
}
