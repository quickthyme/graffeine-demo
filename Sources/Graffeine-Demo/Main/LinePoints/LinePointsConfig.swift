import UIKit
import Graffeine

class LinePointsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, line, point, pointLabel
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 16, region: .topGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply({
                    $0.unitText.colors = [.black]
                    $0.labelHorizontalAlignmentMode = .left
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelVPadding = 4.0
                    $0.labelHPadding = -5
                    $0.unitText.fontSize = 16.0
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 28, region: .leftGutter),

            GraffeineLineLayer(id: ID.line)
                .apply({
                    $0.unitLine.colors = [.black]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                    $0.smoothing = .catmullRom(12)
                }),

            GraffeinePlotLayer(id: ID.point)
                .apply({
                    $0.unitColumn.margin = unitMargin
                    $0.unitFill.colors = [.white]
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 4.0
                    $0.diameter = .explicit(20.0)

                    $0.selection.isEnabled = true
                    $0.selection.radial.diameter = .explicit(24.0)
                    $0.selection.fill.color = .black
                    $0.selection.line.thickness = 6.0
                }),

            GraffeinePlotLabelLayer(id: ID.pointLabel)
                .apply({
                    $0.unitColumn.margin = unitMargin
                    $0.unitText.colors = [.systemRed, .blue, .purple]
                    $0.unitText.fontSize = 10
                    $0.unitShadow.color = .black
                    $0.unitShadow.opacity = 0.5
                    $0.unitShadow.radius = 0.5

                    $0.selection.text.color = .white
                    $0.selection.shadow.color = .white
                })
        ]
    }
}
