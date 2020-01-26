import UIKit
import Graffeine

class ScatterplotConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, vectorPlots1, vectorPlots2, vectorPlots3
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 28, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 64, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 64, region: .leftGutter),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [UIColor(white: 0.98, alpha: 0.8)]
                    $0.unitLine.thickness = 2.0
                    $0.data = GraffeineData(valueMax: Double(2), values: [0, 1, 2])
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.unitLine.colors = [.white]
                    $0.unitLine.colors = [UIColor(white: 0.98, alpha: 0.8)]
                    $0.unitLine.thickness = 2.0
                    $0.data = GraffeineData(valueMax: Double(2), values: [0, 1, 2])
                }),

            GraffeinePlotLayer(id: ID.vectorPlots1)
                .apply ({
                    $0.diameter = .explicit(32.0)
                    $0.unitFill.colors = [UIColor.init(red: 0.33, green: 0.08, blue: 0.12, alpha: 0.5)]
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 2.0
                    $0.unitColumn.margin = unitMargin

                    $0.selection.isEnabled = true
                    $0.selection.radial.diameter = .explicit(48.0)
                    $0.selection.line.thickness = 3
                }),

            GraffeinePlotLayer(id: ID.vectorPlots2)
                .apply ({
                    $0.diameter = .explicit(24.0)
                    $0.unitFill.colors = [UIColor(red: 0.16, green: 0.19, blue: 0.55, alpha: 0.5)]
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 2.0
                    $0.unitColumn.margin = unitMargin

                    $0.selection.isEnabled = true
                    $0.selection.radial.diameter = .explicit(32.0)
                    $0.selection.line.thickness = 3
                }),

            GraffeinePlotLayer(id: ID.vectorPlots3)
                .apply ({
                    $0.diameter = .explicit(16.0)
                    $0.unitFill.colors = [UIColor(red: 0.04, green: 0.44, blue: 0.26, alpha: 0.5)]
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 2.0
                    $0.unitColumn.margin = unitMargin

                    $0.selection.isEnabled = true
                    $0.selection.radial.diameter = .explicit(24.0)
                    $0.selection.line.thickness = 3
                })
        ]
    }
}
