import UIKit

extension CirclesViewController {

    enum CellID: String, CaseIterable {
        case PieSlices = "PieSlicesCell"
        case Scatterplot = "ScatterplotCell"

        static let SectionTitle: [Self: String] = [
            .PieSlices: "Pie Slices",
            .Scatterplot: "Scatter Plot",
        ]

        static func get(for indexPath: IndexPath) -> Self {
            switch (indexPath.section, indexPath.row) {
            case (0, 0): return .PieSlices
            case (1, 0): return .Scatterplot
            default: return .Scatterplot
            }
        }

        static func getTableCellIdentifier(for indexPath: IndexPath) -> String {
            return get(for: indexPath).rawValue
        }

        static func getTableSectionTitle(for indexPath: IndexPath) -> String {
            let id = get(for: indexPath)
            return SectionTitle[id]!
        }

        static func register(with table: UITableView) {
            for id in allCases {
                table.register(UINib(nibName: id.rawValue, bundle: Bundle.main),
                               forCellReuseIdentifier: id.rawValue)
            }
        }
    }
}
