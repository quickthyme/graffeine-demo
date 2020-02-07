import UIKit
import Graffeine

class PieSlicesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case pie, labels, labelLines
    }

    let colors: [UIColor] = [
        UIColor.white.modifiedByAdding(alpha: -0.44),
        UIColor.red.modifiedByAdding(alpha: -0.44),
        UIColor.systemYellow.modifiedByAdding(alpha: -0.44),
        UIColor.systemIndigo.modifiedByAdding(alpha: -0.44),
        UIColor.systemGreen.modifiedByAdding(alpha: -0.44),
        UIColor.systemPurple.modifiedByAdding(alpha: -0.44),
        UIColor.systemRed.modifiedByAdding(alpha: -0.44),
        UIColor.yellow.modifiedByAdding(alpha: -0.44),
        UIColor.blue.modifiedByAdding(alpha: -0.44),
        UIColor.green.modifiedByAdding(alpha: -0.44),
        UIColor.systemGray.modifiedByAdding(alpha: -0.44),
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.pie)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .percentage(0.55)
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.25
                    $0.shadowColor = UIColor.black.cgColor
                    $0.shadowOpacity = 0.4
                    $0.shadowRadius = 2.0
                    $0.shadowOffset = CGSize(width: 0, height: 1.0)
                    $0.selection.radial.outerDiameter = .percentage(0.65)
                    $0.selection.radial.centerOffsetDiameter = .percentage(0.10)
                    $0.selection.isEnabled = true
                }),

            GraffeineRadialLabelLayer(id: ID.labels)
                .apply ({
                    $0.clockwise = true
                    $0.centerRotation = 270
                    $0.diameter = .percentage(0.68)
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 13
                    $0.labelAlignment.horizontal = .centerLeftRight
                    $0.labelAlignment.vertical = .centerTopBottom
                    $0.selection.radial.outerDiameter = .percentage(0.78)
                }),

            GraffeineRadialLineLayer(id: ID.labelLines)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .percentage(0.66)
                    $0.innerDiameter = .percentage(0.56)
                    $0.unitLine.colors = [.systemGray]
                    $0.unitLine.thickness = 1.5
                    $0.unitLine.dashPattern = [1, 1]
                    $0.selection.radial.outerDiameter = .percentage(0.76)
                    $0.selection.radial.innerDiameter = .percentage(0.66)
                })
        ]
    }
}
