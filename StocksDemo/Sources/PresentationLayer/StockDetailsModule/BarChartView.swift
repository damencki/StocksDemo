import UIKit

class BarChartView: UIView {    
    private lazy var stackView = UIStackView {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 10
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
    
    func update(stock: Stock) {
        let buyingValueIndex =  stock.getProfit().buyingPriceIndex
        let sellingValueIndex = stock.getProfit().sellingPriceIndex
        let views = stock.values.map { _ in BarView() }
           views.forEach { stackView.addArrangedSubview($0) }
           for index in 0 ..< stock.values.count {
            let highlited = (index == buyingValueIndex) || (index == sellingValueIndex)
            views[index].update(value: stock.values[index], maximumValue: 1000, highlited: highlited)
           }
    }
}
