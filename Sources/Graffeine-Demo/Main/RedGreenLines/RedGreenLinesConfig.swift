import UIKit
import Graffeine

class RedGreenLinesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, redLine, redLineProj, greenLine, greenLineProj
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter, height: 28, region: .topGutter)
                .apply ({
                    $0.colors = [.white]
                    $0.labelHorizontalAlignmentMode = .center
                    $0.labelVerticalAlignmentMode = .bottom
                    $0.labelVPadding = 4.0
                    $0.fontSize = 16.0
                    $0.data = GraffeineLayer.Data(labels: ["PROJECTIONS"])
                }),

            GraffeineVerticalGutter(id: ID.rightGutter, width: 64, region: .rightGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelHorizontalAlignmentMode = .left
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelHPadding = 4.0
                    $0.labelVPadding = -8.0
                    $0.colors = [.red, .orange, .yellow, .green, .lightGray]
                    $0.fontSize = 11
                    $0.data = GraffeineLayer.Data(labels: ["50,000", "37,500", "25,000", "12,500"])
                }),

            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.colors = [.lightGray]
                    $0.labelHorizontalAlignmentMode = .centerLeftRight
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelVPadding = 4.0
                    $0.data = GraffeineLayer.Data(labels: ["PAST", "PRESENT", "FUTURE"])
                }),

            GraffeineVerticalGutter(id: ID.leftGutter, width: 64, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelHorizontalAlignmentMode = .right
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelHPadding = 4.0
                    $0.labelVPadding = -8.0
                    $0.colors = [.red, .orange, .yellow, .green, .lightGray]
                    $0.fontSize = 11
                    $0.data = GraffeineLayer.Data(labels: ["50,000", "37,500", "25,000", "12,500"])
                }),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.dashPattern = [1, 3]
                    $0.thickness = 0.5
                    $0.data = GraffeineLayer.Data(valueMax: 6, values: [0, 1, 2, 3, 4, 5, 6])
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

            GraffeineLineLayer(id: ID.redLineProj)
                .apply ({
                    $0.colors = [.red]
                    $0.unitMargin = unitMargin
                    $0.dashPattern = [4, 3]
                    $0.dashPhase = 4
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

        GraffeineLineLayer(id: ID.greenLineProj)
            .apply ({
                $0.colors = [.green]
                $0.unitMargin = unitMargin
                $0.dashPattern = [4, 3]
                $0.dashPhase = 4
                $0.thickness = 8.0
                $0.lineJoin = .round
            })
        ]
    }
}
