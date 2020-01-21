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
                    $0.colors = [UIColor(white: 0.0, alpha: 0.5)]
                    $0.thickness = 1.0
                }),

            GraffeineGridLineLayer(id: ID.vGrid)
                .apply ({
                    $0.colors = [UIColor(white: 0.0, alpha: 0.5)]
                    $0.thickness = 1.0
                }),

            GraffeinePlotLayer(id: ID.vectorPlots)
                .apply ({
                    $0.colors = [.black]
                    $0.unitMargin = unitMargin
                    $0.plotDiameter = 12.0
                    $0.plotBorderThickness = 3.0
                    $0.plotBorderColors = [.white]
                    $0.unitShadow.color = .black
                    $0.unitShadow.opacity = 0.8
                    $0.unitShadow.radius = 2.0
                    $0.unitShadow.offset = CGSize(width: 0, height: 0)
                })
        ]
    }
}
