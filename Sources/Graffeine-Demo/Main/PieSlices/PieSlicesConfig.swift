import UIKit
import Graffeine

class PieSlicesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case pie, pieLabels, pieLabelLines
    }

    let colors: [UIColor] = [.red, .purple, .blue, .orange, .systemPink, .systemIndigo]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter,    height: 16, region: .topGutter),
            GraffeineVerticalLabelLayer  (id: ID.rightGutter,  width:  16, region: .rightGutter),
            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 16, region: .bottomGutter),
            GraffeineVerticalLabelLayer  (id: ID.leftGutter,   width:  16, region: .leftGutter),

            GraffeineRadialSegmentLayer(id: ID.pie)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .percentage(0.65)
                    $0.innerDiameter = .percentage(0.25)
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 2
                    $0.shadowColor = UIColor.black.cgColor
                    $0.shadowOpacity = 0.6
                    $0.shadowRadius = 4.0
                    $0.shadowOffset = CGSize(width: 0, height: 1.5)

                    $0.selection.radial.outerDiameter = .percentage(0.80)
                    $0.selection.radial.innerDiameter = .percentage(0.40)
                    $0.selection.radial.centerOffsetDiameter = .percentage(0.15)
                    $0.selection.isEnabled = true
                }),

            GraffeineRadialLabelLayer(id: ID.pieLabels)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .percentage(0.43)
                    $0.unitText.colors = [.white]
                    $0.unitText.fontSize = 13
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.radial.outerDiameter = .percentage(1.10)
                    $0.selection.text.color = .black
                    $0.selection.text.alignment = .init(horizontal: .centerLeftRight,
                                                        vertical: .centerTopBottom)
                }),

            GraffeineRadialLineLayer(id: ID.pieLabelLines)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .percentage(1.00)
                    $0.innerDiameter = .percentage(0.84)
                    $0.unitLine.colors = [.clear]
                    $0.unitLine.thickness = 1.5
                    $0.unitLine.dashPattern = [1, 1]
                    $0.selection.line.color = .darkGray
                })
        ]
    }
}
