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
    
    func update(value: Int, maximumValue: Int, highlited: Bool) {
        self.value = value
        self.maximumValue = maximumValue
        if highlited {
            highliteFilledView()
        }
        updateFilledView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFilledView()
    }
    
    private func highliteFilledView() {
        filledView.backgroundColor = .cmykGreen
        filledView.layer.shadowColor = UIColor.cmykGreen.cgColor
        filledView.layer.shadowOpacity = 0.8
        filledView.layer.shadowOffset = .zero
        filledView.layer.shadowRadius = 5
    }
    
    private func updateFilledView() {
        let totalHeight = bounds.height
        let filledHeight = (CGFloat(integerLiteral: value) * totalHeight) / CGFloat(integerLiteral: maximumValue)
        UIView.animate(withDuration: 0.3) {
            self.topFilledViewConstraint?.update(inset: filledHeight)
            self.layoutIfNeeded()
        }
    }
}
