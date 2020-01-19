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
        let barLayerInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalGutter(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.colors = [.purple]
                    $0.labelHorizontalAlignmentMode = .center
                    $0.labelVerticalAlignmentMode = .top
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 50, region: .leftGutter)
                .apply ({
                    $0.insets = UIEdgeInsets(top: -6, left: 0, bottom: -6, right: 0)
                    $0.rowMargin = unitMargin
                    $0.colors = [.darkGray]
                    $0.labelHorizontalAlignmentMode = .right
                    $0.labelVerticalAlignmentMode = .centerTopBottom
                    $0.data = GraffeineData(labels: ["high", "medium", "low"])
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.colors = [.darkGray]
                    $0.dashPattern = [1, 4]
                    $0.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 10, values: [0, 2.5, 5, 7.5, 10])
                }),

            GraffeineBarLayer(id: ID.descendingBars)
                .apply ({
                    $0.insets = barLayerInsets
                    $0.unitMargin = unitMargin
                    $0.colors = [.purple]
                })
        ]
    }
}
