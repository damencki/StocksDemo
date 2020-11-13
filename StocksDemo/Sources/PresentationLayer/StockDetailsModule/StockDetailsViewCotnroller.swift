import SnapKit
import UIKit

protocol StockDetailsViewProtocol: class {
    
}

class StockDetailsViewCotnroller: UIViewController, StockDetailsViewProtocol {
    var presenter: StockDetailsPresenterProtocol!
}
