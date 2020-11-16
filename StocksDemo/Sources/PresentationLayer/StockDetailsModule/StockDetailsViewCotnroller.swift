import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func setValuesCount(_ count: Int)
    func update(stock: Stock)
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    var presenter: StockDetailsPresenterProtocol!

    private lazy var barCharView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didTapUpdate))
        
        view.addSubview(barCharView)
        barCharView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(400)
        }
        presenter.viewDidLoad()
    }
    
    @objc private func didTapUpdate() {
        presenter.update()
    }
    
    func setValuesCount(_ count: Int) {
        barCharView.barsCount = count
    }
    
    func update(stock: Stock) {
        let buyingPriceIndex = stock.getProfit().buyingPriceIndex
        let sellingPriceIndex = stock.getProfit().sellingPriceIndex

        var barViewModels = [BarViewModel]()
        
        for index in 0 ..< stock.values.count {
            let isHighlited = (buyingPriceIndex == index) || (sellingPriceIndex == index)
            let barViewModel = BarViewModel(value: stock.values[index], isHighlited: isHighlited)
            barViewModels.append(barViewModel)
        }
        barCharView.update(models: barViewModels)
    }
}
