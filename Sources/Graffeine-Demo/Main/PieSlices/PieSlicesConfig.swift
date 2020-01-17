import UIKit
import Graffeine

class PieSlicesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case pie
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineHorizontalGutter(id: ID.topGutter,    height: 16, region: .topGutter),
            GraffeineVerticalGutter  (id: ID.rightGutter,  width:  16, region: .rightGutter),
            GraffeineHorizontalGutter(id: ID.bottomGutter, height: 16, region: .bottomGutter),
            GraffeineVerticalGutter  (id: ID.leftGutter,   width:  16, region: .leftGutter),

            GraffeinePieLayer(id: ID.pie)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .percentage(0.9)
                    $0.colors = [.red, .purple, .blue, .orange, .yellow, .systemIndigo]
                    $0.borderColors = [.black]
                    $0.borderThickness = 2
                    $0.shouldUseDataValueMax = true
                })
        ]
    }
}
