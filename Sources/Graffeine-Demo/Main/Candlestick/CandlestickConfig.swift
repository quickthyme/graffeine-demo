import UIKit
import Graffeine

class CandlestickConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, candle, wick, candleLabel
    }

    func marchingAntsAnimation(dashPhase: Int, clockwise: Bool) -> CAAnimation {
        let toValue = (clockwise) ? 0 - dashPhase : dashPhase
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: toValue)
        animation.duration = 1
        animation.repeatCount = .infinity
        return animation
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 6.0
        let candleInsets = UIEdgeInsets.init(top:  0, left: 16, bottom:  0, right: 16)

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
                    $0.unitLine.thickness = 0.25
                    $0.unitColumn.subdivision.offset = .percentage(0.49)
                    $0.unitColumn.subdivision.width = .explicit(0.5)
                    $0.selection.line.color = UIColor(patternImage: UIImage(named: "diagonal_lines")!)
                }),

            GraffeineBarLayer(id: ID.candle)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.roundedEnds = .both(3)
                    $0.selection.isEnabled = true
                    $0.selection.fill.color = UIColor(patternImage: UIImage(named: "diagonal_lines")!)
                    $0.selection.line.color = .white
                    $0.selection.line.thickness = 2
                    $0.selection.line.dashPattern = [2, 2]
                    $0.selection.animation = marchingAntsAnimation(dashPhase: 4, clockwise: true)
                }),

            GraffeineBarLabelLayer(id: ID.candleLabel)
                .apply ({
                    $0.unitColumn.margin = unitMargin
                    $0.insets = candleInsets
                    $0.unitText.colors = [.clear]
                    $0.unitText.fontSize = 12.0
                    $0.labelAlignment.horizontal = .left
                    $0.labelAlignment.vertical = .top
                    $0.labelPadding.vertical = -16
                    $0.labelPadding.horizontal = -32
                    $0.selection.text.color = .white
                    $0.selection.fill.color = UIColor(white: 0.06, alpha: 0.72)
                })
        ]
    }
}
