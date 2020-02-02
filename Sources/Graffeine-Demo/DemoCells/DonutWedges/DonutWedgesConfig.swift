import UIKit
import Graffeine

class DonutWedgesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case pie, pieLabels, pieLabelLines
    }

    let colors: [UIColor] = [
        UIColor.red.modifiedByAdding(alpha: -0.44, brightness: 0.1),
        UIColor.purple.modifiedByAdding(alpha: -0.44, brightness: 0.1),
        UIColor.blue.modifiedByAdding(alpha: -0.44, brightness: 0.1),
        UIColor.orange.modifiedByAdding(alpha: -0.44, brightness: 0.1),
        UIColor.systemPink.modifiedByAdding(alpha: -0.44, brightness: 0.1),
        UIColor.systemIndigo.modifiedByAdding(alpha: -0.44, brightness: 0.1)
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.pie)
                .apply ({
                    $0.clockwise = false
                    $0.rotation = 90
                    $0.outerDiameter = .percentage(0.55)
                    $0.innerDiameter = .percentage(0.20)
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 0.5
                    $0.shadowColor = UIColor.black.cgColor
                    $0.shadowOpacity = 0.6
                    $0.shadowRadius = 3.0
                    $0.shadowOffset = CGSize(width: 0, height: 1.5)
                    $0.selection.radial.outerDiameter = .percentage(0.65)
                    $0.selection.radial.innerDiameter = .percentage(0.30)
                    $0.selection.radial.centerOffsetDiameter = .percentage(0.10)
                    $0.selection.isEnabled = true
                }),

            GraffeineRadialLabelLayer(id: ID.pieLabels)
                .apply ({
                    $0.clockwise = false
                    $0.rotation = 90
                    $0.diameter = .percentage(0.375)
                    $0.unitText.colors = [.white]
                    $0.unitText.fontSize = 13
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.radial.outerDiameter = .percentage(0.78)
                    $0.selection.text.color = .black
                    $0.selection.text.alignment = .init(horizontal: .centerLeftRight,
                                                        vertical: .centerTopBottom)
                }),

            GraffeineRadialLineLayer(id: ID.pieLabelLines)
                .apply ({
                    $0.clockwise = false
                    $0.rotation = 90
                    $0.outerDiameter = .percentage(0.78)
                    $0.innerDiameter = .percentage(0.68)
                    $0.unitLine.colors = [.clear]
                    $0.unitLine.thickness = 1.5
                    $0.unitLine.dashPattern = [1, 1]
                    $0.selection.line.color = .darkGray
                })
        ]
    }
}
