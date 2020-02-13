import UIKit
import Graffeine

class RadarZoneConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case gridLat, gridLon, label, zone1, zone2
    }

    var polyMorphAnimator: GraffeineRadialPolyDataAnimating {
        return GraffeineAnimation.Data.RadialPoly.Morph(duration: 1.0, timing: .easeInEaseOut)
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let rotation: Int = 234

        let lonData = GraffeineData(valueMax: 5,
                                    valuesHi: [1, 1, 1, 1, 1],
                                    labels: ["Accuracy", "Capacity", "Stability", "Taste", "Volume"])

        graffeineView.layers = [

            GraffeineRadialGridLayer(id: ID.gridLat)
                .apply({
                    $0.maxDiameter = .percentage(0.80)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.join = .round
                    $0.data = GraffeineData(valueMax: 10, valuesHi: [0.1, 2.5, 5, 7.5, 10])
                }),

            GraffeineRadialLineLayer(id: ID.gridLon)
                .apply({
                    $0.rotation = rotation
                    $0.outerDiameter = .percentage(0.80)
                    $0.innerDiameter = .percentage(0.00)
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.join = .bevel
                    $0.unitLine.dashPattern = [2, 3]
                    $0.data = lonData
                }),

            GraffeineRadialLabelLayer(id: ID.label)
                .apply ({
                    $0.clockwise = true
                    $0.centerRotation = rotation
                    $0.diameter = .percentage(0.85)
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 12
                    $0.labelAlignment.horizontal = .centerLeftRight
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.data = lonData
                }),

            GraffeineRadialPolyLayer(id: ID.zone1)
                .apply({
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(0.80)
                    $0.unitFill.colors = [.salmonAlpha]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                    $0.unitAnimation.data.add(animator: polyMorphAnimator, for: .reload)
                }),

            GraffeineRadialPolyLayer(id: ID.zone2)
                .apply({
                    $0.rotation = rotation
                    $0.maxDiameter = .percentage(0.80)
                    $0.unitFill.colors = [.eggplantAlpha]
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                    $0.unitAnimation.data.add(animator: polyMorphAnimator, for: .reload)
                })
        ]
    }
}
