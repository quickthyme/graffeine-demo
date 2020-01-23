import UIKit
import Graffeine

class ScatterplotConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case hGrid, vGrid, vectorPlots, imagePlots
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 28, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 64, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 26, region: .bottomGutter),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 64, region: .leftGutter),

            GraffeineGridLineLayer(id: ID.hGrid)
                .apply ({
                    $0.flipXY = true
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 1.0
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 1.0
                }),

            GraffeinePlotLayer(id: ID.vectorPlots)
                .apply ({
                    $0.diameter = .explicit(8.0)
                    $0.unitFill.colors = [.black]
                    $0.unitLine.colors = [.white]
                    $0.unitLine.thickness = 2.0
                    $0.unitMargin = unitMargin

                    $0.selection.isEnabled = true
                    $0.selection.radial.diameter = .explicit(16.0)
                })
        ]
    }
}
