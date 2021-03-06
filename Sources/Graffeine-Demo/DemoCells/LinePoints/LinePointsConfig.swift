import UIKit
import Graffeine

class LinePointsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, line, point, pointLabel
    }

    var lineAnimator: GraffeineLineDataAnimating {
        return GraffeineAnimation.Data.Line.Morph(duration: 2.0, timing: .easeInEaseOut)
    }

    var pointAnimator: GraffeinePlotDataAnimating {
        return GraffeineAnimation.Data.Plot.FadeIn(duration: 2.0,
                                                   timing: .easeInEaseOut,
                                                   delayRatio: 0.99)
    }

    var pointLabelAnimator: GraffeinePlotLabelDataAnimating {
        return GraffeineAnimation.Data.PlotLabel.FadeIn(duration: 2.0,
                                                        timing: .easeInEaseOut,
                                                        delayRatio: 0.99)
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),
            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 28, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter)
                .apply({
                    $0.labelAlignment.horizontal = .left
                    $0.labelPadding.horizontal = -3
                    $0.unitColumn.reducedByOne = true
                    $0.unitText.fontSize = 6
                }),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 28, region: .leftGutter),

            GraffeineLineLayer(id: ID.line)
                .apply({
                    $0.unitLine.colors = [.label]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 8.0
                    $0.unitLine.join = .round
                    $0.unitLine.cap  = .round
                    $0.unitAnimation.data.add(animator: lineAnimator, for: .reload)
                    $0.smoothing = .catmullRom(12)
                }),

            GraffeinePlotLayer(id: ID.point)
                .apply({
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.reducedByOne = true
                    $0.unitFill.colors = [.inverseLabel]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 4.0
                    $0.diameter = .explicit(22.0)
                    $0.unitAnimation.data.add(animator: pointAnimator, for: .reload)
                    $0.selection.isEnabled = true
                    $0.selection.radial.outerDiameter = .explicit(24.0)
                    $0.selection.fill.color = .label
                    $0.selection.line.thickness = 6.0
                }),

            GraffeinePlotLabelLayer(id: ID.pointLabel)
                .apply({
                    $0.unitColumn.margin = unitMargin
                    $0.unitColumn.reducedByOne = true
                    $0.unitText.colors = [.systemRed, .systemBlue, .systemPurple]
                    $0.unitText.fontSize = 11
                    $0.unitAnimation.data.add(animator: pointLabelAnimator, for: .reload)
                    $0.selection.text.color = .inverseLabel
                })
        ]
    }
}
