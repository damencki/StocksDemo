import SnapKit
import UIKit

class StockCell: UITableViewCell {
    private struct Constants {
        static let defaultPadding = 16
        static let separatorLineHeight = 1
        static let nextButtonSize = CGSize(width: 10, height: 16)
        static let trendIconSize = CGSize(width: 10, height: 5)
        static let valueLabelWidth = 35
    }
    
    private lazy var nameLabel = UILabel {
        $0.font = .systemFont(ofSize: 14)
    }
    
    private lazy var tickerNameLabel = UILabel {
        $0.font = .systemFont(ofSize: 16)
    }
    
    private lazy var valueLabel = UILabel {
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .right
    }
    
    private lazy var trendImageView = UIImageView {
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var nextImageView = UIImageView {
        $0.image = .nextIcon
    }
    
    private lazy var separatorLineView = UIView {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.defaultPadding)
            $0.leading.equalToSuperview().offset(Constants.defaultPadding)
        }
        
        contentView.addSubview(tickerNameLabel)
        tickerNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(Constants.defaultPadding)
        }
        
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.leading.equalTo(tickerNameLabel.snp.trailing).offset(Constants.defaultPadding)
            $0.width.equalTo(Constants.valueLabelWidth)
        }
        
        contentView.addSubview(trendImageView)
        trendImageView.snp.makeConstraints {
            $0.leading.equalTo(valueLabel.snp.trailing).offset(Constants.defaultPadding / 2)
            $0.centerY.equalTo(valueLabel)
            $0.size.equalTo(Constants.trendIconSize)
        }
        
        contentView.addSubview(nextImageView)
        nextImageView.snp.makeConstraints {
            $0.leading.equalTo(trendImageView.snp.trailing).offset(Constants.defaultPadding)
            $0.trailing.equalToSuperview().inset(Constants.defaultPadding)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.nextButtonSize)
        }
        
        contentView.addSubview(separatorLineView)
        separatorLineView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalTo(Constants.separatorLineHeight)
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.defaultPadding)
        }
    }
    
    private func updateTrend(value: String, color: UIColor, image: UIImage?) {
        valueLabel.text = value
        valueLabel.textColor = color
        trendImageView.image = image
    }
    
    private func reset() {
        nameLabel.text = nil
        tickerNameLabel.text = nil
        valueLabel.text = nil
        trendImageView.image = nil
    }
    
    func update(_ stock: Stock) {
        reset()
        nameLabel.text = stock.name
        tickerNameLabel.text = stock.tickerName
        
        guard let lastStockValue = stock.prices.last?.value else {
            return
        }
        switch stock.getTrend() {
        case .up:
            updateTrend(value: String(lastStockValue), color: .cmykGreen, image: .upIcon)
        case .down:
            updateTrend(value: String(lastStockValue), color: .cmykRed, image: .downIcon)
        case .equal:
            updateTrend(value: String(lastStockValue), color: .label, image: nil)
        }
    }
}
