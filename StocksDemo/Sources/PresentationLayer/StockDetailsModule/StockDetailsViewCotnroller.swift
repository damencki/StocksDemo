import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func setValuesCount(_ count: Int)
    func updateBarChart(_ barViewModels: [BarViewModel])
    func updateNavigationTitle(_ title: String)
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    private struct Constants {
        static let horizontalSpacing = 10
        static let verticalSpacing = 20
        static let barChartViewHeight = 400
    }
    
    private lazy var barCharView = BarChartView()
    
    var presenter: StockDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didTapUpdate))
        
        view.addSubview(barCharView)
        barCharView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.horizontalSpacing)
            $0.trailing.equalToSuperview().inset(Constants.horizontalSpacing)
            $0.height.equalTo(Constants.barChartViewHeight)
        }
        presenter.viewDidLoad()
    }
    
    @objc private func didTapUpdate() {
        presenter.update()
    }
    
    func setValuesCount(_ count: Int) {
        barCharView.barsCount = count
    }
    
    func updateBarChart(_ barViewModels: [BarViewModel]) {
        barCharView.update(models: barViewModels)
    }
    
    func updateNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
}
