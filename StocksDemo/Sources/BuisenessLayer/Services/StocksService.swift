import Foundation

protocol StocksServiceProtocol {
    func getStocks() -> [Stock]
    func update() -> [Stock]
}

class StocksService: StocksServiceProtocol {
    private let stub: StubProtocol
    
    init(stub: StubProtocol) {
        self.stub = stub
    }
    
    func getStocks() -> [Stock] {
        return stub.getStocks()
    }
    
    func update() -> [Stock] {
        return stub.update()
    }
}
