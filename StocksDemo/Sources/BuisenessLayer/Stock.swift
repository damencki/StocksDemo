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
}
