import Foundation

protocol StockListPresenterProtocol: class {
    func viewWillAppear()
    func didSelect(stock: Stock)
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    
    required init(view: StockListViewProtocol) {
        self.view = view
    }
    
    func viewWillAppear() {
        view?.update(stocks: Stub().getStocks())
    }
    
    func didSelect(stock: Stock) {
        view?.show(module: ModulesBuilder.createStockDetailsModule(stock: stock))
    }
}
