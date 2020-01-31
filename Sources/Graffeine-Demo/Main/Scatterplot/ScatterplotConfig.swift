import UIKit
import Graffeine

class ScatterplotConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, vectorPlots1, vectorPlots2, vectorPlots3
        case labels1, labels2, labels3
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)
        let insets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 72, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 72, region: .leftGutter),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [UIColor(white: 0.5, alpha: 1.0)]
                    $0.unitLine.thickness = 1.5
                    $0.data = GraffeineData(valueMax: Double(2), values: [0, 1, 2])
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.unitLine.colors = [UIColor(white: 0.5, alpha: 1.0)]
                    $0.unitLine.thickness = 1.5
                    $0.data = GraffeineData(valueMax: Double(2), values: [0, 1, 2])
                }),

            GraffeinePlotLayer(id: ID.vectorPlots1)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(24.0)
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .black
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [6, 6]
                }),

            GraffeinePlotLayer(id: ID.vectorPlots2)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(32.0)
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .black
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [6, 6]
                }),

            GraffeinePlotLayer(id: ID.vectorPlots3)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(48.0)
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .black
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [8, 8]
                }),

            GraffeinePlotLabelLayer(id: ID.labels1)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.black]
                }),

            GraffeinePlotLabelLayer(id: ID.labels2)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.black]
                }),

            GraffeinePlotLabelLayer(id: ID.labels3)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.black]
                })
        ]
    }
}
