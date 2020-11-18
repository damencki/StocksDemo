import Foundation

protocol StubProtocol {
    func getStocks() -> [Stock]
    
    /// Update stocks
    /// - Returns: Stocks with updated prices
    func update() -> [Stock]
}

class Stub: StubProtocol {
    private var stocks: [Stock] = []
    
    init() {
        self.stocks = self.generateStocks()
    }
    
    private func generateStocks() -> [Stock] {
        let appleStock = Stock(id: UUID().uuidString, prices: generatePrices(), name: "Apple", tickerName: "APL")
        let relianceStock = Stock(id: UUID().uuidString, prices: generatePrices(), name: "Reliance", tickerName: "RIL")
        let axisBankStock = Stock(id: UUID().uuidString, prices: generatePrices(), name: "Axis Bank", tickerName: "AXS")
        let bhartiAirtelStock = Stock(id: UUID().uuidString, prices: generatePrices(), name: "Bharti Airtel", tickerName: "AIR")
        let marutiSuzukiStock = Stock(id: UUID().uuidString, prices: generatePrices(), name: "Maruti Suzuki", tickerName: "MSZ")
        stocks = [appleStock, relianceStock, axisBankStock, bhartiAirtelStock, marutiSuzukiStock]
        return stocks
    }
    
    private func generatePrices() -> [Price] {
        var prices = [Price]()
        for i in -9...0 {
            guard let date = Calendar.current.date(byAdding: .day, value: i, to: Date()) else {
                continue
            }
            let price = Price(date: date, value: Int.random(in: 0...999))
            prices.append(price)
        }
        return prices
    }
    
    func getStocks() -> [Stock] {
        return stocks
    }
    
    func update() -> [Stock] {
        for stockIndex in 0..<stocks.count {
            for priceIndex in 0..<stocks[stockIndex].prices.count {
                stocks[stockIndex].prices[priceIndex].value = Int.random(in: 0...999)
            }
        }
        return stocks
    }
}
