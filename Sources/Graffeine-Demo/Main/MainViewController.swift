import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Vertical Descending Bars"
        case 1: return "Red Green Lines"
        case 2: return "Horizontal Grouped Bars"
        case 3: return "Line Points"
        case 4: return "Scatter Plot"
        case 5: return "Pie Slices"
        default: return ""
        }
    }

    func getCellId(for indexPath: IndexPath) -> String {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return "VerticalDescendingBarsCell"
        case (1, 0): return "RedGreenLinesCell"
        case (2, 0): return "HorizontalGroupedBarsCell"
        case (3, 0): return "LinePointsCell"
        case (4, 0): return "ScatterplotCell"
        case (5, 0): return "PieSlicesCell"
        default: return "VerticalDescendingBarsCell"
        }
    }
}
