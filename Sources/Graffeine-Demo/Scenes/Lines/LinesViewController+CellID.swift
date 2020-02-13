import UIKit

extension LinesViewController {

    enum CellID: String, CaseIterable {
        case AreaLines = "AreaLinesCell"
        case LinePoints = "LinePointsCell"
        case RadarZone = "RadarZoneCell"
        case RedGreenLines = "RedGreenLinesCell"
        case Triforce = "TriforceCell"

        static let SectionTitle: [Self: String] = [
            .AreaLines: "Area Lines",
            .LinePoints: "Line Points and Smoothing",
            .RadarZone: "Radar Zone",
            .RedGreenLines: "Red Green Lines",
            .Triforce: "Triforce"
        ]

        static func get(for indexPath: IndexPath) -> Self {
            switch (indexPath.section, indexPath.row) {
            case (0, 0): return .RedGreenLines
            case (1, 0): return .LinePoints
            case (2, 0): return .AreaLines
            case (3, 0): return .RadarZone
            case (4, 0): return .Triforce
            default: return .Triforce
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
