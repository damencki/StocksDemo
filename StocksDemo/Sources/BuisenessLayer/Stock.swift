import Foundation

enum Trend {
    case up
    case down
    case equal
}

struct Stock {
    let id: String
    var values: [Int]
    let name: String
    let tickerName: String
    var test = "Test"
    
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
    
    func getProfit() -> (maximumProfit:Int, buingPrice: Int, sellingPrice: Int, buyingPriceIndex: Int, sellingPriceIndex: Int) {
        var minimalStockPrice = values[0]
        let maximumStockPrice = values[1]
        var maximumProfit = maximumStockPrice - minimalStockPrice
        var buingPrice = minimalStockPrice
        var sellingPrice = maximumStockPrice
      
        var potentilBuyingPriceIndex = 0
        var buyingPriceIndex = potentilBuyingPriceIndex
        
        var sellingPriceIndex = 1
        
        for index in 1..<values.count {
            let currentPrice = values[index]
            let potentialProfit = currentPrice - minimalStockPrice
            
            if potentialProfit > maximumProfit {
                maximumProfit = potentialProfit
                //set buying price
                buingPrice = minimalStockPrice
                
                //set selling price
                sellingPrice = currentPrice
                sellingPriceIndex = index
                buyingPriceIndex = potentilBuyingPriceIndex
            }
            if currentPrice < minimalStockPrice {
                minimalStockPrice = currentPrice
                potentilBuyingPriceIndex = index
            }
        }
        return (maximumProfit: maximumProfit, buingPrice: buingPrice, sellingPrice: sellingPrice, buyingPriceIndex: buyingPriceIndex, sellingPriceIndex: sellingPriceIndex)
    }
}
