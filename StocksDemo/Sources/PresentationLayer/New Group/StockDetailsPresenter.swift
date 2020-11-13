import Foundation

protocol StockDetailsPresenterProtocol: class {
    
}

class StockDetailsPresenter: StockDetailsPresenterProtocol {
    private weak var view: StockDetailsViewProtocol?
    
    required init(view: StockDetailsViewProtocol) {
        self.view = view
    }
}
