import UIKit
import Graffeine

class ProgressIndicatorsConfigBar: GraffeineViewConfig {

    enum ID: Hashable {
        case track, progress
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let trackLayer = GraffeineBarLayer(id: ID.track)
            .apply ({
                $0.flipXY = true
                $0.unitFill.colors = [.systemGray5]
                $0.roundedEnds = .both(6)
                $0.data = GraffeineData.init(valueMax: 100, valuesHi: [100])
            })

        let maskLayer = GraffeineBarLayer(layer: trackLayer)
        maskLayer.bounds.size = CGSize(width: 1200, height: 24)
        maskLayer.anchorPoint = CGPoint(x: 0, y: 0)

        let progressLayer = GraffeineBarLayer(id: ID.progress)
            .apply ({
                $0.flipXY = true
                $0.unitFill.colors = [.systemBlue]
                $0.data = GraffeineData.init(valueMax: 100, valuesHi: [0])
                $0.mask = maskLayer
            })

        graffeineView.layers = [trackLayer, progressLayer]
    }
}
