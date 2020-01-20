import UIKit
import Graffeine

class PieSlicesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case pie, pieLabels
    }

    let colors: [UIColor] = [.red, .purple, .blue, .orange, .yellow, .systemIndigo]

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
                    $0.diameter = .percentage(0.9)
                    $0.holeDiameter = .percentage(0.4)
                    $0.colors = colors
                    $0.borderColors = [.black]
                    $0.borderThickness = 2
                    $0.shouldUseDataValueMax = true
                }),

            GraffeineRadialLabelLayer(id: ID.pieLabels)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .percentage(0.65)
                    $0.colors = [.white]
                    $0.shouldUseDataValueMax = true
                    $0.fontSize = 12
                })
        ]
    }
}
