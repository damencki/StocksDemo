import RxSwift
import Foundation

protocol StockListPresenterProtocol: class {
    func viewDidLoad()
    func didSelect(stock: Stock)
    func didTapUpdate()
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    private let stocksService: StocksServiceProtocol
    private let disposeBag = DisposeBag()
    
    required init(view: StockListViewProtocol, stocksService: StocksServiceProtocol) {
        self.view = view
        self.stocksService = stocksService
    }
    
    func viewDidLoad() {
        stocksService.getStocks().subscribe  { [weak self] stocks in
            self?.view?.update(stocks: stocks)
        }.disposed(by: disposeBag)
    }
    
    func didSelect(stock: Stock) {
        let stockDetailsModule = ModulesBuilder.createStockDetailsModule(stock: stock, stocksService: stocksService)
        view?.show(module: stockDetailsModule)
    }
    
    func didTapUpdate() {
        stocksService.refresh()
    }
}
