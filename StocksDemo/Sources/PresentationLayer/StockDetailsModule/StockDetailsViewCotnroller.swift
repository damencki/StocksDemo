import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func update(stock: Stock)
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    var presenter: StockDetailsPresenterProtocol!

    private lazy var barCharView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(barCharView)
        barCharView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(400)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    func update(stock: Stock) {
        barCharView.update(stock: stock)
    }
}
