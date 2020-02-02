import UIKit

class CirclesViewController: UIViewController {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CellID.register(with: table)
    }
}
