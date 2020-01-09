import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = getCellId(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let cell = cell as? DataAppliable {
            cell.applyData()
        }
        return cell
    }

    func getCellId(for indexPath: IndexPath) -> String {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return "VerticalDescendingBarsCell"
        default: return "VerticalDescendingBarsCell"
        }
    }
}
