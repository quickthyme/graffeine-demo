import UIKit
import Graffeine

class TooLowForZeroConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case bgGrid, fgGrid, bar, barLabel
    }

    let barColors: [UIColor] = [
        .systemRed, .systemOrange, .systemYellow, .systemGreen,
        .systemTeal, .systemBlue, .systemIndigo, .systemPurple
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 1.0
        let barLayerInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 16, region: .bottomGutter),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.insets = UIEdgeInsets(top: -6, left: 0, bottom: -5, right: 0)
                    $0.rowMargin = unitMargin
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 11
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.labelPadding.horizontal = 6.0
                    $0.data = GraffeineData(labels: ["10", "0", "-10"])
                }),

            GraffeineGridLineLayer(id: ID.bgGrid)
                .apply ({
                    $0.unitLine.colors = [.systemGray]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.dashPattern = [2, 2]
                    $0.data = GraffeineData(valueMax: 10, valuesHi: [2.5, 7.5])
                }),

            GraffeineBarLayer(id: ID.bar)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.colors = [.unleaded]
                    $0.unitLine.thickness = 0.1
                    $0.selection.isEnabled = true
                    $0.selection.fill.color = .unleaded
                }),

            GraffeineHorizontalLabelLayer(id: ID.barLabel, height: 26, region: .main)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 9
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .label
                    $0.insets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
                }),

            GraffeineGridLineLayer(id: ID.fgGrid)
                .apply ({
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 10, valuesHi: [0, 5, 10])
                })
        ]
    }
}
