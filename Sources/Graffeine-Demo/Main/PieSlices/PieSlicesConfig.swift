import UIKit
import Graffeine

class PieSlicesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case pie, pieLabels
    }

    let colors: [UIColor] = [.red, .purple, .blue, .orange, .systemPink, .systemIndigo]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter,    height: 16, region: .topGutter),
            GraffeineVerticalLabelLayer  (id: ID.rightGutter,  width:  16, region: .rightGutter),
            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 16, region: .bottomGutter),
            GraffeineVerticalLabelLayer  (id: ID.leftGutter,   width:  16, region: .leftGutter),

            GraffeinePieLayer(id: ID.pie)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .percentage(0.88)
                    $0.holeDiameter = .percentage(0.38)
                    $0.selection.radial.diameter = .percentage(0.96)
                    $0.selection.radial.holeDiameter = .percentage(0.46)
                    $0.selection.isEnabled = true
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 2
                    $0.shadowColor = UIColor.black.cgColor
                    $0.shadowOpacity = 0.7
                    $0.shadowRadius = 4.0
                    $0.shadowOffset = CGSize(width: 0, height: 2)
                }),

            GraffeineRadialLabelLayer(id: ID.pieLabels)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .percentage(0.63)
                    $0.selection.radial.diameter = .percentage(0.71)
                    $0.unitText.colors = [UIColor(white: 0.99, alpha: 0.88)]
                    $0.unitText.fontSize = 12
                    $0.unitShadow.color = .black
                    $0.unitShadow.opacity = 0.9
                    $0.unitShadow.radius = 1.6
                    $0.unitShadow.offset = CGSize(width: 0, height: 0)
                })
        ]
    }
}
