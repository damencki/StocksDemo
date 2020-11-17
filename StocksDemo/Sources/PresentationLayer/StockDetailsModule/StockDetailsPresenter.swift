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
    
    func viewDidLoad() {
        view?.setValuesCount(stock.values.count)
        view?.updateBarChart(convert(stock: stock))
        view?.updateNavigationTitle(stock.tickerName)
    }
    
    func update() {
        let stocks = stockService.update()
        guard let stock = stocks.first(where: { $0.id == stock.id })  else {
            return
        }
        self.stock = stock
        
        view?.updateBarChart(convert(stock: stock))
        flowDelegate?.didStocksUpdate()
    }
    
    private func convert(stock: Stock) -> [BarViewModel] {
        let buyingPriceIndex = getProfit(stock.values).buyingPriceIndex
        let sellingPriceIndex = getProfit(stock.values).sellingPriceIndex

        var barViewModels = [BarViewModel]()
        
        for index in 0 ..< stock.values.count {
            let isHighlited = (buyingPriceIndex == index) || (sellingPriceIndex == index)
            let barViewModel = BarViewModel(value: stock.values[index], isHighlited: isHighlited)
            barViewModels.append(barViewModel)
        }
        return barViewModels
    }
}
