import UIKit
import Graffeine

class ScatterplotConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case bottomGutter, leftGutter
        case hGrid, vGrid, hMarks, vMarks
        case vectorPlots1, vectorPlots2, vectorPlots3
        case labels1, labels2, labels3
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)
        let insets = UIEdgeInsets(top: 28, left: 28, bottom: 28, right: 28)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 32, region: .bottomGutter)
                .apply ({
                    $0.labelAlignment.horizontal = .left
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.vertical = 6
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 12
                    $0.data = GraffeineData(labels: ["Prefers Pie Charts (%) →"])
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 32, region: .leftGutter)
                .apply ({
                    $0.labelAlignment.horizontal = .left
                    $0.labelAlignment.vertical = .bottom
                    $0.labelPadding.vertical = 1
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 12
                    $0.labelRotation = 270
                    $0.data = GraffeineData(labels: ["Prefers Bar Charts (%) →"])
                }),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.data = GraffeineData(valueMax: 2.0, valuesHi: [0, 2])
                    $0.fill.color = .inverseLabel
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.data = GraffeineData(valueMax: Double(2), valuesHi: [0, 2])
                }),

            GraffeineGridLineLayer(id: ID.hMarks)
                .apply ({
                    $0.alignment = .right
                    $0.length = .explicit(8)
                    $0.flipXY = true
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 1.0
                    $0.data = GraffeineData(valueMax: Double(10), valuesHi: Array<Int>(1...9).map { Double($0) })
                }),

            GraffeineGridLineLayer(id: ID.vMarks)
                .apply ({
                    $0.alignment = .left
                    $0.length = .explicit(8)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 1.0
                    $0.data = GraffeineData(valueMax: Double(10), valuesHi: Array<Int>(1...9).map { Double($0) })
                }),

            GraffeinePlotLayer(id: ID.vectorPlots1)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(24.0)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .label
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [6, 6]
                }),

            GraffeinePlotLayer(id: ID.vectorPlots2)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(32.0)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .label
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [6, 6]
                }),

            GraffeinePlotLayer(id: ID.vectorPlots3)
                .apply ({
                    $0.insets = insets
                    $0.diameter = .explicit(48.0)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.positioner = .xy

                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(alpha: -0.3) }
                    $0.selection.line.color = .label
                    $0.selection.line.thickness = 1
                    $0.selection.line.dashPattern = [8, 8]
                }),

            GraffeinePlotLabelLayer(id: ID.labels1)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 12
                }),

            GraffeinePlotLabelLayer(id: ID.labels2)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 16
                }),

            GraffeinePlotLabelLayer(id: ID.labels3)
                .apply ({
                    $0.insets = insets
                    $0.positioner = .xy
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 22
                })
        ]
    }
}
