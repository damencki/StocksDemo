import SnapKit
import UIKit

class BarView: UIView {
    private lazy var filledView = UIView {
        $0.backgroundColor = .filled
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private var topFilledViewConstraint: Constraint?
    private var value: Int = 0
    private var maximumValue: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .background
        
        addSubview(filledView)
        filledView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            topFilledViewConstraint = $0.top.equalTo(snp.bottom).constraint
        }
    }
    
    func update(value: Int, maximumValue: Int) {
        self.value = value
        self.maximumValue = maximumValue
        updateFilledView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFilledView()
    }
    
    private func updateFilledView() {
        let totalHeight = bounds.height
        let filledHeight = (CGFloat(integerLiteral: value) * totalHeight) / CGFloat(integerLiteral: maximumValue)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.topFilledViewConstraint?.update(inset: filledHeight)
            self?.layoutIfNeeded()
        }
    }
}
