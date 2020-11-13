import SnapKit
import UIKit

protocol StockListViewProtocol: class {
    func update(stocks: [Stock])
}

class StockListViewController: UIViewController, StockListViewProtocol {
    private lazy var tableView = UITableView {
        $0.dataSource = self
        $0.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.self))
        $0.separatorStyle = .none
    }
    
    private var stocks: [Stock] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: StockListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    private func setupUI() {
        navigationItem.title = "Stock​ ​Exchange"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func update(stocks: [Stock]) {
        self.stocks = stocks
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
