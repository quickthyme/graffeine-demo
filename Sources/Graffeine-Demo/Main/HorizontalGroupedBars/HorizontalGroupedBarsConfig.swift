import UIKit
import Graffeine

class HorizontalGroupedBarsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, bars1, bars2
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 8.0

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalGutter(id: ID.rightGutter, width: 32, region: .rightGutter),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.colors = [.white]
                    $0.labelHorizontalAlignmentMode = .right
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelHPadding = -6.0
                    $0.labelVPadding = 2.0
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 32, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelVerticalAlignmentMode = .center
                    $0.colors = [.white]
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.flipXY = true
                    $0.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 20, values: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20])
                }),

            GraffeineBarLayer(id: ID.bars1)
                .apply ({
                    $0.flipXY = true
                    $0.unitMargin = unitMargin
                    $0.colors = [UIColor(white: 1.0, alpha: 0.7)]
                    $0.unitSubdivision = GraffeineLayer.UnitSubdivision(index: 0, width: .percentage(0.5))
                }),

            GraffeineBarLayer(id: ID.bars2)
                .apply ({
                    $0.flipXY = true
                    $0.unitMargin = unitMargin
                    $0.colors = [UIColor(white: 0.7, alpha: 0.7)]
                    $0.unitSubdivision = GraffeineLayer.UnitSubdivision(index: 1, width: .percentage(0.5))
                })
        ]
    }
}
