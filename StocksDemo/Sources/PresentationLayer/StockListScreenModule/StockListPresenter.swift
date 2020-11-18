import Foundation

protocol StockListPresenterProtocol: class {
    func viewDidLoad()
    func didSelect(stock: Stock)
    func didTapUpdate()
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    private let stocksService: StocksServiceProtocol
    
    required init(view: StockListViewProtocol, stocksService: StocksServiceProtocol) {
        self.view = view
        self.stocksService = stocksService
    }
    
    func viewDidLoad() {
        view?.update(stocks: stocksService.getStocks())
    }
    
    func didSelect(stock: Stock) {
        let stockDetailsModule = ModulesBuilder.createStockDetailsModule(stock: stock, stocksService: stocksService, flowDelegate: self)
        view?.show(module: stockDetailsModule)
    }
    
    func didTapUpdate() {
        let stocks = stocksService.update()
        view?.update(stocks: stocks)
    }
}

extension StockListPresenter: StockDetailsPresenterFlowDelegate {
    func didStocksUpdate() {
        view?.update(stocks: stocksService.getStocks())
    }
}
