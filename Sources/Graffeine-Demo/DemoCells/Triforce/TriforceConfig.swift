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
                    $0.unitFill.colors = [UIColor(white: 0.0, alpha: 0.18)]
                    $0.unitLine.join = .bevel
                    $0.data = GraffeineData(valueMax: 9, valuesHi: [9, 9, 9])
                }),

            GraffeineRadialPolyLayer(id: ID.triforce)
                .apply({
                    $0.insets = insets
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(diameterPct)
                    $0.unitFill.colors = [UIColor.systemYellow.modifiedByAdding(alpha: -0.44)]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.20
                    $0.unitLine.join = .bevel
                    $0.unitAnimation.data.add(animator: polyMorphAnimator, for: .reload)
                }),

            GraffeineRadialPolyLayer(id: ID.gridMid)
                .apply({
                    $0.insets = insets
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(diameterPct)
                    $0.unitLine.colors = [.brown]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.join = .bevel
                    $0.unitLine.dashPattern = [2, 4]
                    $0.data = GraffeineData(valueMax: 9, valuesHi: [6, 6, 6])
                }),

            GraffeineRadialPolyLayer(id: ID.gridLo)
                .apply({
                    $0.insets = insets
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(diameterPct)
                    $0.unitLine.colors = [.brown]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.join = .bevel
                    $0.unitLine.dashPattern = [2, 4]
                    $0.data = GraffeineData(valueMax: 9, valuesHi: [3, 3, 3])
                }),

            GraffeineRadialLabelLayer(id: ID.label)
                .apply ({
                    $0.insets = insets
                    $0.clockwise = true
                    $0.centerRotation = rotation
                    $0.diameter = .percentage(diameterPct + 0.05)
                    $0.unitText.colors = [UIColor.systemYellow.modifiedByAdding(alpha: -0.3)]
                    $0.unitText.fontSize = 18
                    $0.unitShadow.color = .brown
                    $0.unitShadow.offset = CGSize(width: 0, height: -0.5)
                    $0.unitShadow.opacity = 0.5
                    $0.unitShadow.radius = 0.1
                    $0.labelAlignment.horizontal = .centerLeftRight
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.data = labelData
                })
        ]
    }
}
