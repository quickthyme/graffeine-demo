import UIKit
import Graffeine

class VerticalDescendingBarsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, descendingBars
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 6.0

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalGutter(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.colors = [.purple]
                    $0.labelAlignmentMode = .center
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.colors = [.darkGray]
                    $0.data = GraffeineLayer.Data(labels: ["high", "", "", "", "", "medium", "", "", "", "", "low"])
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.colors = [.lightGray]
                    $0.dashPattern = [1, 3]
                    $0.thickness = 0.5
                    $0.data = GraffeineLayer.Data(valueMax: 10, values: [2.5, 5, 7.5, 10])
                }),

            GraffeineBarLayer(id: ID.descendingBars)
                .apply ({
                    $0.barMargin = unitMargin
                    $0.colors = [.purple]
                })
        ]
    }
}
