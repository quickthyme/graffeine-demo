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

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 28, region: .topGutter)
                .apply ({
                    $0.unitText.colors = [.white]
                    $0.labelHorizontalAlignmentMode = .center
                    $0.labelVerticalAlignmentMode = .bottom
                    $0.labelVPadding = 4.0
                    $0.fontSize = 16.0
                    $0.data = GraffeineData(labels: ["PROJECTIONS"])
                }),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 64, region: .rightGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelHorizontalAlignmentMode = .left
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelHPadding = 4.0
                    $0.labelVPadding = -8.0
                    $0.unitText.colors = [.red, .orange, .yellow, .green, .lightGray]
                    $0.fontSize = 11
                    $0.data = GraffeineData(labels: ["50,000", "37,500", "25,000", "12,500"])
                }),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter)
                .apply ({
                    $0.unitText.colors = [.lightGray]
                    $0.labelHorizontalAlignmentMode = .centerLeftRight
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelVPadding = 4.0
                    $0.data = GraffeineData(labels: ["PAST", "PRESENT", "FUTURE"])
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 64, region: .leftGutter)
                .apply ({
                    $0.rowMargin = unitMargin
                    $0.labelHorizontalAlignmentMode = .right
                    $0.labelVerticalAlignmentMode = .top
                    $0.labelHPadding = 4.0
                    $0.labelVPadding = -8.0
                    $0.unitText.colors = [.red, .orange, .yellow, .green, .lightGray]
                    $0.fontSize = 11
                    $0.data = GraffeineData(labels: ["50,000", "37,500", "25,000", "12,500"])
                }),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.unitLine.dashPattern = [1, 3]
                    $0.unitLine.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 6, values: [0, 1, 2, 3, 4, 5, 6])
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.unitLine.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.unitLine.dashPattern = [1, 3]
                    $0.unitLine.thickness = 0.5
                    $0.data = GraffeineData(valueMax: 50, values: [0, 12.5, 25.0, 37.5, 50.0])
                }),

            GraffeineLineLayer(id: ID.redLine)
                .apply ({
                    $0.unitLine.colors = [.red]
                    $0.unitMargin = unitMargin
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                }),

            GraffeineLineLayer(id: ID.redLineProj)
                .apply ({
                    $0.unitLine.colors = [.red]
                    $0.unitMargin = unitMargin
                    $0.unitLine.dashPattern = [4, 3]
                    $0.unitLine.dashPhase = 4
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                }),

            GraffeineLineLayer(id: ID.greenLine)
                .apply ({
                    $0.unitLine.colors = [.green]
                    $0.unitMargin = unitMargin
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                }),

            GraffeineLineLayer(id: ID.greenLineProj)
                .apply ({
                    $0.unitLine.colors = [.green]
                    $0.unitMargin = unitMargin
                    $0.unitLine.dashPattern = [4, 3]
                    $0.unitLine.dashPhase = 4
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                })
        ]
    }
}
