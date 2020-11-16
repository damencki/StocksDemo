import Foundation

enum Trend {
    case up
    case down
    case equal
}

struct Stock {
    let id: String
    let values: [Int]
    let name: String
    let tickerName: String
    
    func getTrend() -> Trend {
        if values.count < 2 {
            return .equal
        } else if values[values.count - 1] > values[values.count - 2] {
            return .up
        } else if values[values.count - 1] == values[values.count - 2] {
            return .equal
        } else {
            return .down
        }
    }
    
    func getProfit() -> (maximumProfit:Int, buingPrice: Int, sellingPrice: Int) {
        var minimalStockPrice = values[0]
        let maximumStockPrice = values[0]
        var maximumProfit = maximumStockPrice - minimalStockPrice
        var buingPrice = minimalStockPrice
        var sellingPrice = maximumStockPrice
        
        for index in 1..<values.count {
            let currentPrice = values[index]
            let potentialProfit = currentPrice - minimalStockPrice
            
            if potentialProfit > maximumProfit {
                maximumProfit = potentialProfit
                //set buying price
                buingPrice = minimalStockPrice
                //set selling price
                sellingPrice = currentPrice
            }
            if currentPrice < minimalStockPrice {
                minimalStockPrice = currentPrice
            }
        }
        return (maximumProfit: maximumProfit, buingPrice: buingPrice, sellingPrice: sellingPrice)
    }
}
