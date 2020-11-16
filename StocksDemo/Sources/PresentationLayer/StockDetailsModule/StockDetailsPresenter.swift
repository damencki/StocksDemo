import Foundation

protocol StockDetailsPresenterProtocol: class {
    func viewDidLoad()
    func update()
}

protocol StockDetailsPresenterFlowDelegate: class {
    func didStocksUpdate()
}

class StockDetailsPresenter: StockDetailsPresenterProtocol {
    private weak var view: StockDetailsViewProtocol?
    private var stock: Stock
    private let stockService: StocksServiceProtocol
    private weak var flowDelegate: StockDetailsPresenterFlowDelegate?
    
    required init(view: StockDetailsViewProtocol,
                  stock: Stock,
                  stockService: StocksServiceProtocol,
                  flowDelegate: StockDetailsPresenterFlowDelegate?) {
        self.view = view
        self.stock = stock
        self.stockService = stockService
        self.flowDelegate = flowDelegate
    }
    
    func viewDidLoad() {
        view?.setValuesCount(stock.values.count)
        view?.update(stock: stock)
    }
    
    func update() {
        let stocks = stockService.update()
        guard let stock = stocks.first(where: { $0.id == stock.id })  else {
            return
        }
        self.stock = stock
        
        view?.update(stock: stock)
        flowDelegate?.didStocksUpdate()
    }
}
