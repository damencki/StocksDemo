import SnapKit
import UIKit

struct BarViewModel {
    let value: Int
    let title: String
    let isHighlited: Bool
}

class BarView: UIView {
    private struct Constants {
        static let animationDuration: TimeInterval = 0.3
    }
    
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
    
    func update(barViewModel: BarViewModel, maximumValue: Int) {
        self.value = barViewModel.value
        self.maximumValue = maximumValue
        setupHighliting(isHighlited: barViewModel.isHighlited)
        updateFilledView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFilledView()
    }
    
    private func setupHighliting(isHighlited: Bool) {
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            self?.filledView.backgroundColor = isHighlited ? .cmykGreen : .filled
            self?.filledView.layer.shadowColor = isHighlited ?  UIColor.cmykGreen.cgColor : nil
            self?.filledView.layer.shadowOpacity = isHighlited ? 0.8 : 0.0
            self?.filledView.layer.shadowOffset = isHighlited ? .zero : CGSize(width: 0.0, height: -3.0)
            self?.filledView.layer.shadowRadius = isHighlited ? 5 : 3
        }
    }
    
    private func updateFilledView() {
        let totalHeight = bounds.height
        let filledHeight = (CGFloat(integerLiteral: value) * totalHeight) / CGFloat(integerLiteral: maximumValue)
        UIView.animate(withDuration: Constants.animationDuration) {
            self.topFilledViewConstraint?.update(inset: filledHeight)
            self.layoutIfNeeded()
        }
    }
}
