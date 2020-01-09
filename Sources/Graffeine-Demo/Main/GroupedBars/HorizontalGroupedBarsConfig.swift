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

            GraffeineVerticalGutter(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.colors = [.white]
                    $0.labelAlignmentMode = .right
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.colors = [.white]
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.flipXY = true
                    $0.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.thickness = 0.5
                    $0.data = GraffeineLayer.Data(valueMax: 20, values: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20])
                }),

            GraffeineBarLayer(id: ID.bars1)
                .apply ({
                    $0.flipXY = true
                    $0.barMargin = unitMargin
                    $0.colors = [.white]
                    $0.barSubdivision = GraffeineBarLayer.Bar.Subdivision(index: 0, width: .percentage(0.5))
                }),

            GraffeineBarLayer(id: ID.bars2)
                .apply ({
                    $0.flipXY = true
                    $0.barMargin = unitMargin
                    $0.colors = [.lightGray]
                    $0.barSubdivision = GraffeineBarLayer.Bar.Subdivision(index: 1, width: .percentage(0.5))
                })
        ]
    }
}
