import UIKit

extension OtherViewController {

    enum CellID: String, CaseIterable {
        case Progress = "ProgressIndicatorsCell"
        case RadarZone = "RadarZoneCell"
        case Scatterplot = "ScatterplotCell"
        case Triforce = "TriforceCell"

        static let SectionTitle: [Self: String] = [
            .Progress: "Progress",
            .RadarZone: "Radar Zone",
            .Scatterplot: "Scatter Plot",
            .Triforce: "Triforce"
        ]

        static func get(for indexPath: IndexPath) -> Self {
            switch (indexPath.section, indexPath.row) {
            case (0, 0): return .RadarZone
            case (1, 0): return .Scatterplot
            case (2, 0): return .Triforce
            case (3, 0): return .Progress
            default: return .Progress
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
