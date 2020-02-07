import UIKit
import Graffeine

class VerticalDescendingBarsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, bar, barLabel
    }

    let barColors: [UIColor] = [
        .systemRed, .systemOrange, .systemYellow, .systemGreen,
        .systemTeal, .systemBlue, .systemIndigo, .systemPurple
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 6.0
        let barLayerInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitText.colors = barColors
                    $0.unitText.fontSize = 11
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.vertical = 3.0
                    $0.selection.text.color = .label
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.insets = UIEdgeInsets(top: -6, left: 0, bottom: -5, right: 0)
                    $0.rowMargin = unitMargin
                    $0.unitText.colors = [.label,
                                          .systemGray,
                                          .systemGray4]
                    $0.unitText.fontSize = 10
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.labelPadding.horizontal = 6.0
                    $0.data = GraffeineData(labels: ["EXC", "AVG", "LOW"])
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.unitLine.colors = [.systemGray]
                    $0.unitLine.dashPattern = [1, 4]
                    $0.unitLine.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 10, valuesHi: [0, 2.5, 5, 7.5, 10])
                }),

            GraffeineBarLayer(id: ID.bar)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitFill.colors = barColors
                    $0.unitLine.colors = [.unleaded]
                    $0.unitLine.thickness = 0.1
                    $0.roundedEnds = .hi(6)
                    $0.selection.isEnabled = true
                    $0.selection.fill.color = .unleaded
                }),

            GraffeineBarLabelLayer(id: ID.barLabel)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitText.colors = [.inverseLabel]
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.vertical = 4
                })
        ]
    }
}
