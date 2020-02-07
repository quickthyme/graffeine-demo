import UIKit
import Graffeine

class DonutWedgesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case donut, labels, labelLines
    }

    let colors: [UIColor] = [
        UIColor.systemTeal.modifiedByAdding(alpha: -0.44),
        UIColor.systemIndigo.modifiedByAdding(alpha: -0.44),
        UIColor.systemGreen.modifiedByAdding(alpha: -0.44),
        UIColor.systemYellow.modifiedByAdding(alpha: -0.44),
        UIColor.systemPurple.modifiedByAdding(alpha: -0.44),
        UIColor.systemOrange.modifiedByAdding(alpha: -0.44)
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.donut)
                .apply ({
                    $0.clockwise = false
                    $0.rotation = 90
                    $0.outerDiameter = .percentage(0.55)
                    $0.innerDiameter = .percentage(0.20)
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.05
                    $0.shadowOpacity = 0.4
                    $0.shadowRadius = 2.0
                    $0.shadowOffset = CGSize(width: 0, height: 1.0)
                    $0.selection.radial.outerDiameter = .percentage(0.65)
                    $0.selection.radial.innerDiameter = .percentage(0.30)
                    $0.selection.radial.centerOffsetDiameter = .percentage(0.10)
                    $0.selection.isEnabled = true
                }),

            GraffeineRadialLabelLayer(id: ID.labels)
                .apply ({
                    $0.clockwise = false
                    $0.centerRotation = 90
                    $0.diameter = .percentage(0.375)
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 13
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.radial.outerDiameter = .percentage(0.78)
                    $0.selection.text.color = .label
                    $0.selection.text.alignment = .init(horizontal: .centerLeftRight,
                                                        vertical: .centerTopBottom)
                }),

            GraffeineRadialLineLayer(id: ID.labelLines)
                .apply ({
                    $0.clockwise = false
                    $0.rotation = 90
                    $0.outerDiameter = .percentage(0.78)
                    $0.innerDiameter = .percentage(0.68)
                    $0.unitLine.colors = [.clear]
                    $0.unitLine.thickness = 1.5
                    $0.unitLine.dashPattern = [1, 1]
                    $0.selection.line.color = .label
                })
        ]
    }
}
