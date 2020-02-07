import UIKit
import Graffeine

class HorizontalGroupedBarsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, bars1, bars2, barLabel1, barLabel2
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 8.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 20, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 32, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 34, region: .bottomGutter)
                .apply ({
                    $0.unitText.fontSize = 12
                    $0.unitText.colors = [.white]
                    $0.labelAlignment.horizontal = .left
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.horizontal = 28.0
                    $0.labelPadding.vertical = -22.0
                    $0.labelRotation = 45
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 32, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelAlignment.vertical = .center
                    $0.labelAlignment.horizontal = .right
                    $0.labelPadding.horizontal = 8.0
                    $0.unitText.fontSize = 13
                    $0.unitText.colors = [.white]
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.dashPattern = [2, 4]
                    $0.data = GraffeineData(valueMax: 20, valuesHi: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20])
                }),

            GraffeineBarLayer(id: ID.bars1)
                .apply ({
                    $0.flipXY = true
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.subdivision.offset = .percentage(0.0)
                    $0.unitColumn.subdivision.width = .percentage(0.5)
                    $0.unitFill.colors = [UIColor(white: 1.0, alpha: 0.4)]
                }),

            GraffeineBarLayer(id: ID.bars2)
                .apply ({
                    $0.flipXY = true
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.subdivision.offset = .percentage(0.5)
                    $0.unitColumn.subdivision.width = .percentage(0.5)
                    $0.unitFill.colors = [UIColor(white: 0.0, alpha: 0.3)]
                }),

            GraffeineBarLabelLayer(id: ID.barLabel1)
                .apply ({
                    $0.flipXY = true
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.subdivision.offset = .percentage(0.0)
                    $0.unitColumn.subdivision.width = .percentage(0.5)
                    $0.labelPadding.horizontal = 3
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .center
                    $0.unitText.colors = [.black]
                    $0.unitText.fontSize = 8
                }),

            GraffeineBarLabelLayer(id: ID.barLabel2)
                .apply ({
                    $0.flipXY = true
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.subdivision.offset = .percentage(0.5)
                    $0.unitColumn.subdivision.width = .percentage(0.5)
                    $0.labelPadding.horizontal = 3
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .center
                    $0.unitText.colors = [.white]
                    $0.unitText.fontSize = 8
                })
        ]
    }
}
