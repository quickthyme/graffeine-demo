import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CellID.register(with: table)
    }
}
