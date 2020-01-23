import UIKit
import Graffeine

class LinePointsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, line, points
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.unitText.colors = [.black]
                    $0.labelHorizontalAlignmentMode = .left
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelVPadding = 4.0
                    $0.labelHPadding = -5
                    $0.unitText.fontSize = 16.0
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 28, region: .leftGutter),

            GraffeineLineLayer(id: ID.line)
                .apply ({
                    $0.unitLine.colors = [.black]
                    $0.unitMargin = unitMargin
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                }),

            GraffeinePlotLayer(id: ID.points)
                .apply ({
                    $0.unitFill.colors = [.black]
                    $0.unitMargin = unitMargin
                    $0.diameter = .explicit(16.0)
                })
        ]
    }
}
