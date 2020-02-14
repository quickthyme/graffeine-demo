import UIKit

extension BarsViewController {

    enum CellID: String, CaseIterable {
        case Candlestick = "CandlestickCell"
        case HorizontalGroupedBars = "HorizontalGroupedBarsCell"
        case TooLowForZero = "TooLowForZeroCell"
        case VerticalDescendingBars = "VerticalDescendingBarsCell"

        static let SectionTitle: [Self: String] = [
            .Candlestick: "Candlestick",
            .HorizontalGroupedBars: "Horizontal Grouped Bars",
            .TooLowForZero: "Too Low For Zero",
            .VerticalDescendingBars: "Vertical Descending Bars"
        ]

        static func get(for indexPath: IndexPath) -> Self {
            switch (indexPath.section, indexPath.row) {
            case (0, 0): return .VerticalDescendingBars
            case (1, 0): return .HorizontalGroupedBars
            case (2, 0): return .TooLowForZero
            case (3, 0): return .Candlestick
            default: return .Candlestick
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
