import Foundation

protocol StocksServiceProtocol {
    func getStocks() -> [Stock]
    func update() -> [Stock]
}

class StocksService: StocksServiceProtocol {
    private let stub = Stub.shared
    
    func getStocks() -> [Stock] {
        return stub.getStocks()
    }
    
    func update() -> [Stock] {
        return stub.update()
    }
}
