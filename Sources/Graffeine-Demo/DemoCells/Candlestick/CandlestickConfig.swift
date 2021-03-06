import UIKit
import Graffeine

class CandlestickConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, candle, wick, candleLabel
    }

    var barMoveAnimator: GraffeineBarDataAnimating {
        return GraffeineAnimation.Data.Bar.Grow(duration: 0.8, timing: .easeOut)
    }

    var labelMoveAnimator: GraffeineLabelDataAnimating {
        return GraffeineAnimation.Data.Label.Slide(duration: 0.8, timing: .easeOut)
    }

    var selectedAnimation: () -> CAAnimation {
        return GraffeineAnimation.Perpetual.MarchingAnts(dashPhase: 4,
                                                         clockwise: true,
                                                         duration: 0.8)
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 4.0
        let candleInsets = UIEdgeInsets.init(top:  0, left: 16, bottom:  0, right: 16)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),
            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 16, region: .rightGutter),
            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter),
            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 8, region: .leftGutter),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.unitLine.colors = [.systemGray2]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.dashPattern = [3, 3]
                    $0.data = GraffeineData(valueMax: 10, valuesHi: Array<Int>(0...10).map {Double($0)})
                }),

            GraffeineBarLayer(id: ID.wick)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.unitFill.colors = [.clear]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.4
                    $0.unitColumn.subdivision.offset = .percentage(0.49)
                    $0.unitColumn.subdivision.width = .explicit(0.48)
                    $0.unitAnimation.data.add(animator: barMoveAnimator, for: .reload)
                    $0.selection.line.thickness = 1.0
                    $0.selection.line.dashPattern = [2, 2]
                    $0.selection.animation = selectedAnimation
                }),

            GraffeineBarLayer(id: ID.candle)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.roundedEnds = .both(2)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.unitAnimation.data.add(animator: barMoveAnimator, for: .reload)
                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(brightness: -0.5) }
                    $0.selection.line.thickness = 1.0
                    $0.selection.line.dashPattern = [2, 2]
                    $0.selection.animation = selectedAnimation
                }),

            GraffeineBarLabelLayer(id: ID.candleLabel)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.unitText.colors = [.clear]
                    $0.unitText.fontSize = 12.0
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.unitAnimation.data.add(animator: labelMoveAnimator, for: .reload)
                    $0.selection.text.color = .inverseLabel
                    $0.selection.fill.color = .label
                })
        ]
    }
}
