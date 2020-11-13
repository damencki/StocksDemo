import Foundation

protocol StockDetailsPresenterProtocol: class {
    func viewDidAppear()
}

class StockDetailsPresenter: StockDetailsPresenterProtocol {
    private weak var view: StockDetailsViewProtocol?
    private let stock: Stock
    
    required init(view: StockDetailsViewProtocol, stock: Stock) {
        self.view = view
        self.stock = stock
    }
    
    func viewDidAppear() {
        view?.update(stock: stock)
    }
}
