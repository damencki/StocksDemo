import Foundation

enum Trend {
    case up
    case down
    case equal
}

struct Stock {
    let id: String
    var prices: [Price]
    let name: String
    let tickerName: String
    
    func getTrend() -> Trend {
        if prices.count < 2 {
            return .equal
        } else if prices[prices.count - 1].value > prices[prices.count - 2].value {
            return .up
        } else if prices[prices.count - 1].value == prices[prices.count - 2].value {
            return .equal
        } else {
            return .down
        }
    }
}
