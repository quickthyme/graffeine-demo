import UIKit
import Graffeine

class VerticalDescendingBarsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, bar, barLabel
    }

    let barColors: [UIColor] = [
        .systemRed, .systemOrange, .systemYellow, .systemGreen,
        .systemTeal, .systemBlue, .systemIndigo, .purple
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
                    $0.selection.text.color = .black
                    $0.selection.shadow.color = .black
                    $0.selection.shadow.radius = 0.33
                    $0.selection.shadow.opacity = 1.0
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.insets = UIEdgeInsets(top: -6, left: 0, bottom: -5, right: 0)
                    $0.rowMargin = unitMargin
                    $0.unitText.colors = [UIColor(white: 0.08, alpha: 1.0),
                                          UIColor(white: 0.08, alpha: 0.6),
                                          UIColor(white: 0.08, alpha: 0.3)]
                    $0.unitText.fontSize = 10
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.labelPadding.horizontal = 6.0
                    $0.data = GraffeineData(labels: ["EXC", "AVG", "LOW"])
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.unitLine.colors = [.darkGray]
                    $0.unitLine.dashPattern = [1, 4]
                    $0.unitLine.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 10, valuesHi: [0, 2.5, 5, 7.5, 10])
                }),

            GraffeineBarLayer(id: ID.bar)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitFill.colors = barColors
                    $0.roundedEnds = .hi(6)
                    $0.unitShadow.color = .black
                    $0.unitShadow.opacity = 0.6
                    $0.unitShadow.radius = 2.6
                    $0.unitShadow.offset = CGSize(width: -1.4, height: 6)

                    $0.selection.isEnabled = true
                    $0.selection.fill.color = UIColor(white: 0.08, alpha: 0.8)
                    $0.maskInsets = UIEdgeInsets(top: -20, left: -20, bottom: 0, right: -20)
                }),

            GraffeineBarLabelLayer(id: ID.barLabel)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitColumn.margin = unitMargin
                    $0.unitText.colors = [UIColor(white: 0.9215, alpha: 1.0)]
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.vertical = 4
                    $0.masksToBounds = true
                    $0.selection.text.color = .white
                })
        ]
    }
}
