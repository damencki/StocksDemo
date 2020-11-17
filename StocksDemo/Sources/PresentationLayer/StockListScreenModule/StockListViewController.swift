import SnapKit
import UIKit

protocol StockListViewProtocol: class {
    func update(stocks: [Stock])
    func show(module: UIViewController)
}

class StockListViewController: UIViewController, StockListViewProtocol {
    private lazy var tableView = UITableView {
        $0.dataSource = self
        $0.delegate = self
        $0.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.self))
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
    
    private var stocks: [Stock] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: StockListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        navigationItem.title = "Stock​ ​Exchange"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didTapUpdateButton))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func didTapUpdateButton() {
        presenter.didTapUpdate()
    }
    
    func update(stocks: [Stock]) {
        self.stocks = stocks
    }
    
    func show(module: UIViewController) {
        navigationController?.pushViewController(module, animated: true)
    }
}

extension StockListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockCell.self), for: indexPath)
        guard let stockCell = cell as? StockCell else {
            return cell
        }
        stockCell.reset()
        stockCell.update(stocks[indexPath.row])
        return stockCell
    }
}

extension StockListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(stock: stocks[indexPath.row])
    }
}
