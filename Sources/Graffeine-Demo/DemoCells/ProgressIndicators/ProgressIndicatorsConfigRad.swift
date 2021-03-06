import UIKit
import Graffeine

class ProgressIndicatorsConfigRad: GraffeineViewConfig {

    enum ID: Hashable {
        case track, progress
    }

    var animatorFast: GraffeineRadialSegmentDataAnimating {
        return GraffeineAnimation.Data.RadialSegment.Automatic(duration: 0.22, timing: .linear)
    }

    var animatorSlow: GraffeineRadialSegmentDataAnimating {
        return GraffeineAnimation.Data.RadialSegment.Automatic(duration: 2.6, timing: .linear)
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let outerDiameter: CGFloat = 32
        let innerDiameter: CGFloat = 20

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.track)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .explicit(outerDiameter)
                    $0.innerDiameter = .explicit(innerDiameter)
                    $0.unitFill.colors = [.systemGray5]
                    $0.data = GraffeineData.init(valueMax: 100, valuesHi: [100])
                }),

            GraffeineRadialSegmentLayer(id: ID.progress)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 270
                    $0.outerDiameter = .explicit(outerDiameter)
                    $0.innerDiameter = .explicit(innerDiameter)
                    $0.unitFill.colors = [.systemBlue]
                    $0.data = GraffeineData.init(valueMax: 100, valuesHi: [0])
                    $0.unitAnimation.data.add(animator: animatorFast, for: .reload)
                    $0.unitAnimation.data.add(animator: animatorSlow, for: .next)
                })
        ]
    }
}
