import Foundation

class Stub {
    private var stocks: [Stock] = []
    
    static let shared = Stub()
    
    private init() {
        self.stocks = self.generateStocks()
    }
    
    private func generateStocks() -> [Stock] {
        let appleStock = Stock(id: UUID().uuidString, values: generateRandomValues(), name: "Apple", tickerName: "APL")
        let relianceStock = Stock(id: UUID().uuidString, values: generateRandomValues(), name: "Reliance", tickerName: "RIL")
        let axisBankStock = Stock(id: UUID().uuidString, values: generateRandomValues(), name: "Axis Bank", tickerName: "AXS")
        let bhartiAirtelStock = Stock(id: UUID().uuidString, values: generateRandomValues(), name: "Bharti Airtel", tickerName: "AIR")
        let marutiSuzukiStock = Stock(id: UUID().uuidString, values: generateRandomValues(), name: "Maruti Suzuki", tickerName: "MSZ")
        stocks = [appleStock, relianceStock, axisBankStock, bhartiAirtelStock, marutiSuzukiStock]
        return stocks
    }
    
    private func generateRandomValues() -> [Int] {
        var values: [Int] = []
        for _ in 0..<10 {
            values.append(Int.random(in: 0...999))
        }
        return values
    }
    
    /// Update stocks
    /// - Returns: Genereted new values of 
    func update() -> [Stock] {
        for index in 0..<stocks.count {
            stocks[index].values = generateRandomValues()
        }
        return stocks
    }
    
    func getStocks() -> [Stock] {
        return stocks
    }
}
