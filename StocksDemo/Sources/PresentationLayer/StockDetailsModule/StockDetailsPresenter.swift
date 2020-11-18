import Foundation

protocol StockDetailsPresenterProtocol: class {
    func viewDidLoad()
    func update()
}

protocol StockDetailsPresenterFlowDelegate: class {
    func didStocksUpdate()
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
    private weak var flowDelegate: StockDetailsPresenterFlowDelegate?
    
    required init(view: StockDetailsViewProtocol,
                  stock: Stock,
                  stockService: StocksServiceProtocol,
                  flowDelegate: StockDetailsPresenterFlowDelegate?) {
        self.view = view
        self.stock = stock
        self.stockService = stockService
        self.flowDelegate = flowDelegate
    }
    
    func viewDidLoad() {
        view?.setValuesCount(stock.prices.count)
        view?.updateBarChart(barViewModels(from: stock))
        view?.updateNavigationTitle(stock.tickerName)
        view?.updateNameLabel(text: stock.name)
        view?.updateDescriptionLabel(text: descriptionText(from: stock))
    }
    
    func update() {
        let stocks = stockService.update()
        guard let stock = stocks.first(where: { $0.id == stock.id })  else {
            return
        }
        self.stock = stock
        
        view?.updateBarChart(barViewModels(from: stock))
        view?.updateDescriptionLabel(text: descriptionText(from: stock))
        flowDelegate?.didStocksUpdate()
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
    
    func getProfits(values: [Int]) -> [StockProfit] {
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
}
