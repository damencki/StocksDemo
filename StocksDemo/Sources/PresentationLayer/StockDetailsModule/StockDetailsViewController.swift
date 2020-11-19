import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    func setValuesCount(_ count: Int)
    func updateBarChart(_ barViewModels: [BarViewModel])
    func updateNavigationTitle(_ title: String)
    func updateNameLabel(text: String)
    func updateDescriptionLabel(text: String)
}

class StockDetailsViewController: UIViewController, StockDetailsViewProtocol {
    private struct Constants {
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 20
        static let barChartViewHeight: CGFloat = 300
    }
    
    private lazy var scrollView = UIScrollView ()
    
    private lazy var stackView = UIStackView {
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.axis = .vertical
        $0.spacing = Constants.verticalSpacing
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: Constants.verticalSpacing, left: Constants.horizontalSpacing, bottom: Constants.verticalSpacing, right: Constants.horizontalSpacing)
    }
    
    private lazy var nameLabel = UILabel {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .label
    }
    
    private lazy var barCharView = BarChartView()
    
    private lazy var descriptionLabel = UILabel {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 0
    }
    
    var presenter: StockDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didTapUpdate))
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(barCharView)
        barCharView.snp.makeConstraints {
            $0.height.equalTo(Constants.barChartViewHeight)
        }
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    @objc private func didTapUpdate() {
        presenter?.update()
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
    
    func updateDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
