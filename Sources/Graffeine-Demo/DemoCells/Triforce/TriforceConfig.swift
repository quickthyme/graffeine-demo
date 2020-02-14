import UIKit
import Graffeine

class TriforceConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case gridHi, gridMid, gridLo, label, triforce
    }

    var polyMorphAnimator: GraffeineRadialPolyDataAnimating {
        return GraffeineAnimation.Data.RadialPoly.Morph(duration: 1.0, timing: .easeInEaseOut)
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let diameterPct: CGFloat = 0.80
        let rotation: Int = 150
        let insets = UIEdgeInsets(top: -32, left: 0, bottom: 32, right: 0)

        let labelData = GraffeineData(valueMax: 3,
                                      valuesHi: [1, 1, 1],
                                      labels: ["Courage", "Power", "Wisdom"])

        graffeineView.layers = [

            GraffeineRadialPolyLayer(id: ID.gridHi)
                .apply({
                    $0.insets = insets
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(diameterPct)
                    $0.unitFill.colors = [UIColor(white: 0.0, alpha: 0.14)]
                    $0.unitLine.join = .bevel
                    $0.data = GraffeineData(valueMax: 9, valuesHi: [9, 9, 9])
                }),

            GraffeineRadialPolyLayer(id: ID.triforce)
                .apply({
                    $0.insets = insets
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(diameterPct)
                    $0.unitFill.colors = [.systemYellow]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.20
                    $0.unitLine.join = .bevel
                    $0.unitAnimation.data.add(animator: polyMorphAnimator, for: .reload)
                }),

            GraffeineRadialLabelLayer(id: ID.label)
                .apply ({
                    $0.insets = insets
                    $0.clockwise = true
                    $0.centerRotation = rotation
                    $0.diameter = .percentage(diameterPct + 0.05)
                    $0.unitText.colors = [.systemYellow]
                    $0.unitText.fontSize = 16
                    $0.labelAlignment.horizontal = .centerLeftRight
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.data = labelData
                })
        ]
    }
}
