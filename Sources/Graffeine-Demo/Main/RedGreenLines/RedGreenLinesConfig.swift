import UIKit
import Graffeine

class RedGreenLinesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, redLine, greenLine
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineVerticalGutter(id: ID.rightGutter, width: 16, region: .rightGutter),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.colors = [.lightGray]
                    $0.labelAlignmentMode = .centerLeftRight
                    $0.data = GraffeineLayer.Data(labels: ["past", "present", "future"])
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 56, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.colors = [.red, .orange, .yellow, .green, .lightGray]
                    $0.data = GraffeineLayer.Data(labels: ["50,000", "37,500", "25,000", "12,500", "0"])
                }),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.dashPattern = [1, 3]
                    $0.thickness = 0.5
                    $0.data = GraffeineLayer.Data(valueMax: 3, values: [0, 1, 2, 3])
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.dashPattern = [1, 3]
                    $0.thickness = 0.5
                    $0.data = GraffeineLayer.Data(valueMax: 50, values: [0, 12.5, 25.0, 37.5, 50.0])
                }),

            GraffeineLineLayer(id: ID.redLine)
                .apply ({
                    $0.colors = [.red]
                    $0.unitMargin = unitMargin
                    $0.thickness = 8.0
                    $0.lineJoin = .round
                }),

            GraffeineLineLayer(id: ID.greenLine)
                .apply ({
                    $0.colors = [.green]
                    $0.unitMargin = unitMargin
                    $0.thickness = 8.0
                    $0.lineJoin = .round
                }),
        ]
    }
}
