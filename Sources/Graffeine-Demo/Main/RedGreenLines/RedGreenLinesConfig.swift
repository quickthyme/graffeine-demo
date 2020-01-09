import UIKit
import Graffeine

class RedGreenLinesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case redLine, greenLine
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
