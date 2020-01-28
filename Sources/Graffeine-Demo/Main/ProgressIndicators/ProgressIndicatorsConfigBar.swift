import UIKit
import Graffeine

class ProgressIndicatorsConfigBar: GraffeineViewConfig {

    enum ID: Hashable {
        case track, progress
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineBarLayer(id: ID.track)
                .apply ({
                    $0.flipXY = true
                    $0.unitFill.colors = [UIColor(white: 0.88, alpha: 0.88)]
                    $0.roundedEnds = .both(6)
                    $0.data = GraffeineData.init(valueMax: 100, values: [100])
                }),

            GraffeineBarLayer(id: ID.progress)
                .apply ({
                    $0.flipXY = true
                    $0.unitFill.colors = [.systemBlue]
                    $0.roundedEnds = .both(6)
                    $0.data = GraffeineData.init(valueMax: 100, values: [0])
                })
        ]
    }
}
