import UIKit

class BarChartView: UIView {
    private struct Constants {
        static let horizontalSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 10
    }
    
    private lazy var barsStackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = Constants.horizontalSpacing
    }
    
    private lazy var valuesStackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = Constants.horizontalSpacing
    }
    
    private lazy var titlesStackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = Constants.horizontalSpacing
    }
    
    private lazy var barViews: [BarView] = []
    private lazy var nameLabels: [UILabel] = []
    private lazy var titleLabels: [UILabel] = []
    
    /// Barc charts count. Default value 0.
    var barsCount: Int = 0 {
        didSet {
            barsStackView.removeAllArangedSubviews()
            barViews = []
            
            valuesStackView.removeAllArangedSubviews()
            nameLabels = []
            
            titlesStackView.removeAllArangedSubviews()
            titleLabels = []
            
            for _ in 0 ..< barsCount {
                let barView = BarView()
                barViews.append(barView)
                barsStackView.addArrangedSubview(barView)
                
                let valueLabel = UILabel {
                    $0.font = .systemFont(ofSize: 10)
                    $0.textAlignment = .center
                }
                nameLabels.append(valueLabel)
                valuesStackView.addArrangedSubview(valueLabel)
                
                let titleLabel = UILabel {
                    $0.font = .systemFont(ofSize: 10)
                    $0.textAlignment = .center
                }
                titleLabels.append(titleLabel)
                titlesStackView.addArrangedSubview(titleLabel)
            }
        }
    }
    
    /// Maximum value of bars. Default value is 1000
    var maximumValue: Int = 1000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(valuesStackView)
        valuesStackView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        addSubview(barsStackView)
        barsStackView.snp.makeConstraints {
            $0.top.equalTo(valuesStackView.snp.bottom).offset(Constants.verticalSpacing)
            $0.leading.trailing.equalToSuperview()
        }
        
        addSubview(titlesStackView)
        titlesStackView.snp.makeConstraints {
            $0.top.equalTo(barsStackView.snp.bottom).offset(Constants.verticalSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func update(models: [BarViewModel]) {
        if models.count == barsCount {
            for index in 0 ..< models.count {
                barViews[index].update(barViewModel: models[index], maximumValue: maximumValue)
                nameLabels[index].text = String(models[index].value)
                titleLabels[index].text = models[index].title
            }
        }
    }
}

