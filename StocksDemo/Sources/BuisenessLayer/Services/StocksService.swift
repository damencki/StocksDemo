import RxSwift
import Foundation

protocol StocksServiceProtocol {    
    func getStocks() -> Observable<[Stock]>
    func refresh()
}

class StocksService: StocksServiceProtocol {
    private let stub: StubProtocol
    private let stocksSubject: BehaviorSubject<[Stock]>
    
    init(stub: StubProtocol) {
        self.stub = stub
        stocksSubject = BehaviorSubject(value: stub.getStocks())
    }
    
    func getStocks() -> Observable<[Stock]> {
        return stocksSubject.asObserver()
    }
    
    func refresh() {
        stocksSubject.onNext(stub.update())
    }
}
