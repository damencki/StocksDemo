import RxSwift
import Foundation

protocol StockDetailsPresenterProtocol: class {
    func viewDidLoad()
    func update()
}

struct StockProfit {
    let buyingIndex: Int
    let sellingIndex: Int
    let profit: Int
}

class StockDetailsPresenter: StockDetailsPresenterProtocol {
    private weak var view: StockDetailsViewProtocol?
    private var stock: Stock
    private let stockService: StocksServiceProtocol
    private let disposeBag = DisposeBag()
    
    required init(view: StockDetailsViewProtocol,
                  stock: Stock,
                  stockService: StocksServiceProtocol) {
        self.view = view
        self.stock = stock
        self.stockService = stockService
    }
    
    private func barViewModels(from stock: Stock) -> [BarViewModel] {
        let profits = getProfits(values: stock.prices.map { $0.value})
        let higlitedIndexes = profits.sorted {$0.profit > $1.profit}.prefix(2).flatMap { [$0.buyingIndex, $0.sellingIndex] }
        
        var barViewModels = [BarViewModel]()
        for index in 0 ..< stock.prices.count {
            let price = stock.prices[index]
            let barViewModel = BarViewModel(value: price.value,
                                            title: string(from: price.date),
                                            isHighlited: higlitedIndexes.contains(index))
            barViewModels.append(barViewModel)
        }
        return barViewModels
    }
    
    private func string(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date)
    }
    
    private func descriptionText(from stock: Stock) -> String{
        let profit = getProfits(values: stock.prices.map{$0.value}).compactMap{$0.profit}.reduce(0, +)
        return "\(profit) - the​ ​maximum​ ​profit​ ​that​ ​can be​ ​made​ ​by​ ​buying​ ​and​ ​by selling​ ​on​ ​consecutive​ ​days."
    }
    
    /// Get profits ranges with profit value
    /// - Parameter values: Integer value more than 0. If values count is less than 2 function returns empty array
    /// - Returns: Profits with buying and selling indexes
    private func getProfits(values: [Int]) -> [StockProfit] {
        if values.count < 2 {
            return []
        }
        
        let null = -1
        
        var stockProfits: [StockProfit] = []
        var currentLocalMinimum: Int = values[0]
        var localMinimumIndex: Int = 0
        
        for index in 1..<values.count {
            if (values[index] <= values[index - 1]) && currentLocalMinimum != null {
                let currentProfit = values[index - 1] - currentLocalMinimum;
                if currentProfit > 0 {
                    stockProfits.append(StockProfit(buyingIndex: localMinimumIndex, sellingIndex: (index - 1), profit: currentProfit))
                }
                currentLocalMinimum = null
                localMinimumIndex = null
            }
            
            if (values[index] > values[index - 1]) {
                if currentLocalMinimum == null {
                    currentLocalMinimum = values[index - 1];
                    localMinimumIndex = index - 1;
                }
                
                if index == (values.count - 1) {
                    stockProfits.append(StockProfit(buyingIndex: localMinimumIndex, sellingIndex: index, profit: (values[index] - currentLocalMinimum)))
                }
            }
        }
        return stockProfits
    }
    
    func viewDidLoad() {
        view?.setValuesCount(stock.prices.count)
        bindings()
    }
    
    private func bindings() {
        stockService.getStocks()            
            .subscribe { [weak self] stocks in
                guard let self = self, let stock = stocks.first(where: { $0.id == self.stock.id })  else {
                    return
                }
                self.view?.updateBarChart(self.barViewModels(from: stock))
                self.view?.updateDescriptionLabel(text: self.descriptionText(from: stock))
                self.view?.updateNameLabel(text: stock.name)
                self.view?.updateNavigationTitle(stock.tickerName)
            } onError: {error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    func update() {
        stockService.refresh()
    }
}
