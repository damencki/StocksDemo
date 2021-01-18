import RxCocoa
import RxSwift
import Foundation

protocol StockListPresenterProtocol: class {
    var didStockSelectAction: PublishSubject<IndexPath> { get }
    var didTapUpdateAction: PublishSubject<Void> { get }
    var stocksObservable: Observable<[Stock]> { get }
}

class StockListPresenter: StockListPresenterProtocol {
    private weak var view: StockListViewProtocol?
    private let stocksService: StocksServiceProtocol
    private let disposeBag = DisposeBag()
    
    let didStockSelectAction = PublishSubject<IndexPath>()
    var didTapUpdateAction = PublishSubject<Void>()
    var stocksObservable: Observable<[Stock]> {
        return stocksService.getStocks()
    }
    
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
        
        didStockSelectAction.asObserver().subscribe { [weak self] indexPath in
            guard let self = self else {
                return
            }
            let stock = self.stocks[indexPath.row]
            self.view?.show(module: ModulesBuilder.createStockDetailsModule(stock: stock, stocksService: self.stocksService))
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        
        didTapUpdateAction.subscribe { [weak self] event in
            self?.stocksService.refresh()
        }
        .disposed(by: disposeBag)
    }
}
