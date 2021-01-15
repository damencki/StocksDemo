import RxCocoa
import RxSwift
import Foundation

protocol StockListPresenterProtocol: class {
    var stockSelectedSubject: PublishSubject<IndexPath> { get }
    func didTapUpdate()
    
    func stocksObservable() -> Observable<[Stock]>
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    private let stocksService: StocksServiceProtocol
    private let disposeBag = DisposeBag()
    
    let stockSelectedSubject = PublishSubject<IndexPath>()
    
    private var stocks = [Stock]()
    
    required init(view: StockListViewProtocol, stocksService: StocksServiceProtocol) {
        self.view = view
        self.stocksService = stocksService
        setup()
    }
    
    func setup() {
        stocksService.getStocks().subscribe { [weak self] stocks in
            self?.stocks = stocks
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)

        stockSelectedSubject.asObserver().subscribe { [weak self] indexPath in
            guard let self = self else {
                return
            }
            let stock = self.stocks[indexPath.row]
            self.view?.show(module: ModulesBuilder.createStockDetailsModule(stock: stock, stocksService: self.stocksService))
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
    }
    
    func didTapUpdate() {
        stocksService.refresh()
    }
    
    func stocksObservable() -> Observable<[Stock]> {
        return stocksService.getStocks()
    }
}
