import Foundation

protocol StockDetailsPresenterProtocol: class {
    func viewDidLoad()
    func update()
}

protocol StockDetailsPresenterFlowDelegate: class {
    func didStocksUpdate()
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
        view?.updateBarChart(barViewModel(from: stock))
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
        
        view?.updateBarChart(barViewModel(from: stock))
        view?.updateDescriptionLabel(text: descriptionText(from: stock))
        flowDelegate?.didStocksUpdate()
    }
    
    private func getProfit(_ values: [Int]) -> (maximumProfit:Int, buingPrice: Int, sellingPrice: Int, buyingPriceIndex: Int, sellingPriceIndex: Int) {
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
            return (maximumProfit: maximumProfit,
                    buingPrice: buingPrice,
                    sellingPrice: sellingPrice,
                    buyingPriceIndex: buyingPriceIndex,
                    sellingPriceIndex: sellingPriceIndex)
        }
    
    private func barViewModel(from stock: Stock) -> [BarViewModel] {
        let buyingPriceIndex = getProfit(stock.prices.map { $0.value }).buyingPriceIndex
        let sellingPriceIndex = getProfit(stock.prices.map { $0.value }).sellingPriceIndex

        var barViewModels = [BarViewModel]()
        
        for index in 0 ..< stock.prices.count {
            let isHighlited = (buyingPriceIndex == index) || (sellingPriceIndex == index)
            let price = stock.prices[index]
            let barViewModel = BarViewModel(value: price.value, title: string(from: price.date), isHighlited: isHighlited)
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
        let profit = getProfit(stock.prices.map{$0.value})
        return "\(profit.maximumProfit) - the​ ​maximum​ ​profit​ ​that​ ​can be​ ​made​ ​by​ ​buying​ ​and​ ​selling​ ​on​ ​consecutive​ ​days. \n\nBuing price - \(profit.buingPrice)\nSelling Price - \(profit.sellingPrice)"
    }
}
