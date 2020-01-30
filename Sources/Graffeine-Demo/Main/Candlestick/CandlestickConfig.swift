import UIKit
import Graffeine

class CandlestickConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, candle, wick, candleLabel
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 6.0
        let candleInsets = UIEdgeInsets.init(top:  0, left: 16, bottom:  0, right: 16)
        let diagonalLines = UIColor(patternImage: UIImage(named: "diagonal_lines")!)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),
            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 16, region: .rightGutter),
            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter),
            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 8, region: .leftGutter),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.unitLine.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.dashPattern = [3, 3]
                    $0.data = GraffeineData(valueMax: 10, values: Array<Int>(0...10).map {Double($0)})
                }),

            GraffeineBarLayer(id: ID.wick)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.unitFill.colors = [.clear]
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 0.5
                    $0.unitColumn.subdivision.offset = .percentage(0.49)
                    $0.unitColumn.subdivision.width = .explicit(0.5)
                    $0.selection.line.color = diagonalLines
                }),

            GraffeineBarLayer(id: ID.candle)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.roundedEnds = .both(3)
                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(brightness: -0.5) }
                    $0.selection.line.color = UIColor(white: 0.88, alpha: 0.88)
                    $0.selection.line.thickness = 3
                    $0.selection.line.dashPattern = [3, 3]
                    $0.selection.animation = GraffeineAnimation.Perpetual.MarchingAnts(dashPhase: 6,
                                                                                       clockwise: true)
                }),

            GraffeineBarLabelLayer(id: ID.candleLabel)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.unitText.colors = [.clear]
                    $0.unitText.fontSize = 12.0
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .white
                    $0.selection.fill.color = UIColor(white: 0.06, alpha: 0.72)
                })
        ]
    }
}
