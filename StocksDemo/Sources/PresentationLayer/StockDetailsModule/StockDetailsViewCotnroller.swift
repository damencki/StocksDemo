import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func setValuesCount(_ count: Int)
    func updateBarChart(_ barViewModels: [BarViewModel])
    func updateNavigationTitle(_ title: String)
    func updateNameLabel(text: String)
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    private struct Constants {
        static let horizontalSpacing = 10
        static let verticalSpacing = 20
        static let barChartViewHeight = 400
    }
    
    private lazy var barCharView = BarChartView()
    
    private lazy var nameLabel = UILabel {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    var presenter: StockDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didTapUpdate))
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalSpacing)
            $0.trailing.equalToSuperview().inset(Constants.horizontalSpacing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.verticalSpacing)
        }
        
        view.addSubview(barCharView)
        barCharView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.verticalSpacing)
            $0.leading.trailing.equalTo(nameLabel)
            $0.height.equalTo(Constants.barChartViewHeight)
        }
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
    
    func updateNameLabel(text: String) {
        nameLabel.text = text
    }
}
