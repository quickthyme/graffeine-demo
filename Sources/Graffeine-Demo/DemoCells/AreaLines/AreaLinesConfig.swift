import UIKit
import Graffeine

class AreaLinesConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case line1, line2, line3
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 0.0

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 22, region: .topGutter),

            GraffeineLineLayer(id: ID.line1)
                .apply({
                    $0.unitLine.colors = [UIColor.blue]
                    $0.unitFill.colors = [UIColor.systemBlue.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                }),

            GraffeineLineLayer(id: ID.line2)
                .apply({
                    $0.unitLine.colors = [UIColor.systemGreen.modifiedByAdding(brightness: -0.2)]
                    $0.unitFill.colors = [UIColor.systemGreen.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                }),

            GraffeineLineLayer(id: ID.line3)
                .apply({
                    $0.unitLine.colors = [UIColor.systemOrange]
                    $0.unitFill.colors = [UIColor.systemYellow.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                })
        ]
    }
}
