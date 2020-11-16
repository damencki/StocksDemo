import Foundation

protocol StockListPresenterProtocol: class {
    func viewDidLoad()
    func viewWillAppear()
    func didSelect(stock: Stock)
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    
    required init(view: StockListViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        let stocks = Stub().getStocks()
        view?.update(stocks: Stub().getStocks())
        stocks.forEach { stock in
            print(stock.name)
            print("")
            print(stock.values)
            print("maximumProfit")
            print(stock.getProfit())
            print("________\n")
        }
    }
    
    func viewWillAppear() {
    }
    
    func didSelect(stock: Stock) {
        view?.show(module: ModulesBuilder.createStockDetailsModule(stock: stock))
    }
}
