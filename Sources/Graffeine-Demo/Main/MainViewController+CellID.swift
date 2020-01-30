import UIKit

extension MainViewController {

    enum CellID: String, CaseIterable {
        case Candlestick = "CandlestickCell"
        case HorizontalGroupedBars = "HorizontalGroupedBarsCell"
        case LinePoints = "LinePointsCell"
        case PieSlices = "PieSlicesCell"
        case ProgressIndicators = "ProgressIndicatorsCell"
        case RedGreenLines = "RedGreenLinesCell"
        case Scatterplot = "ScatterplotCell"
        case VerticalDescendingBars = "VerticalDescendingBarsCell"

        static let DemoTitle: [Self: String] = [
            .Candlestick: "Candlestick",
            .HorizontalGroupedBars: "Horizontal Grouped Bars",
            .LinePoints: "Line Points and Smoothing",
            .PieSlices: "Pie Slices",
            .ProgressIndicators: "Progress Indicators",
            .RedGreenLines: "Red Green Lines",
            .Scatterplot: "Scatter Plot",
            .VerticalDescendingBars: "Vertical Descending Bars"
        ]

        static func get(for indexPath: IndexPath) -> Self {
            switch (indexPath.section, indexPath.row) {
            case (0, 0): return .VerticalDescendingBars
            case (1, 0): return .RedGreenLines
            case (2, 0): return .HorizontalGroupedBars
            case (3, 0): return .LinePoints
            case (4, 0): return .Scatterplot
            case (5, 0): return .PieSlices
            case (6, 0): return .Candlestick
            case (7, 0): return .ProgressIndicators
            default: return .ProgressIndicators
            }
        }

        static func getRawValue(for indexPath: IndexPath) -> String {
            return get(for: indexPath).rawValue
        }

        static func getDemoTitle(for indexPath: IndexPath) -> String {
            let id = get(for: indexPath)
            return DemoTitle[id]!
        }

        static func register(with table: UITableView) {
            for id in allCases {
                table.register(UINib(nibName: id.rawValue, bundle: Bundle.main),
                               forCellReuseIdentifier: id.rawValue)
            }
        }
    }
}
