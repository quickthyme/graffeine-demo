import UIKit
import Graffeine

class ProgressIndicatorsConfigRad: GraffeineViewConfig {

    enum ID: Hashable {
        case track, progress
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let outerDiameter: CGFloat = 32
        let innerDiameter: CGFloat = 20

        graffeineView.layers = [

            GraffeinePieLayer(id: ID.track)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .explicit(outerDiameter)
                    $0.holeDiameter = .explicit(innerDiameter)
                    $0.unitFill.colors = [UIColor(white: 0.88, alpha: 0.88)]
                    $0.data = GraffeineData.init(valueMax: 100, values: [100])
                }),

            GraffeinePieLayer(id: ID.progress)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.diameter = .explicit(outerDiameter)
                    $0.holeDiameter = .explicit(innerDiameter)
                    $0.unitFill.colors = [.systemBlue]
                    $0.data = GraffeineData.init(valueMax: 100, values: [0])
                })
        ]
    }
}
