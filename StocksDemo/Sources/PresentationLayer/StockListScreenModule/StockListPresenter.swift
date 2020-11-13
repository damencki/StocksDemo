import Foundation

protocol StockListPresenterProtocol: class {
    func viewDidLoad()
    func viewWillAppear()
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    
    required init(view: StockListViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.update(stocks: Stub().getStocks())
    }
}
