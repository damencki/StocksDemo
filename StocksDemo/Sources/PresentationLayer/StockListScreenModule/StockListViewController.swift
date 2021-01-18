import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol StockListViewProtocol: class {
    func show(module: UIViewController)
}

class StockListViewController: UIViewController, StockListViewProtocol {
    private lazy var tableView = UITableView {
        $0.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.self))
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
    }
        
    var presenter: StockListPresenter?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        navigationItem.title = "Stock​ ​Exchange"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: nil)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        guard let presenter = presenter else {
            return
        }
        
        presenter.stocksObservable
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: StockCell.self), cellType: StockCell.self)) {row, stock, cell in
                cell.update(stock)
            }
            .disposed(by: disposeBag)
        
        presenter.itemSelectedAction.subscribe { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }.disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .bind(to: presenter.didStockSelectAction)
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx
            .tap
            .bind(to: presenter.didTapUpdateAction)
            .disposed(by: disposeBag)
    }
    
    func show(module: UIViewController) {
        navigationController?.pushViewController(module, animated: true)
    }
}
