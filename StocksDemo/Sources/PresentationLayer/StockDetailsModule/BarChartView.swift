import UIKit

class BarChartView: UIView {
    private lazy var stackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private lazy var barViews: [BarView] = []
    
    var barsCount: Int = 0 {
        didSet {
            stackView.arrangedSubviews.forEach {
                stackView.removeArrangedSubview($0)
            }
            barViews = []
            
            for _ in 0 ..< barsCount {
                let barView = BarView()
                barViews.append(barView)
                stackView.addArrangedSubview(barView)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func update(values: [Int]) {
        if values.count == barsCount {
            for index in 0 ..< values.count {
                barViews[index].update(value: values[index], maximumValue: 1000, highlited: false)
            }
        }
    }
}

