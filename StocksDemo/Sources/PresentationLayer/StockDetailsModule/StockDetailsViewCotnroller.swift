import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func setValuesCount(_ count: Int)
    func updateBarChart(_ barViewModels: [BarViewModel])
    func updateNavigationTitle(_ title: String)
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    private lazy var barCharView = BarChartView()
    
    var presenter: StockDetailsPresenterProtocol!
    
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
    
    func updateBarChart(_ barViewModels: [BarViewModel]) {
        barCharView.update(models: barViewModels)
    }
    
    func updateNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
}
