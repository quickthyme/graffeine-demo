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
        let selectionShadowRadius: CGFloat = 2.0
        let selectionShadowOpacity: CGFloat = 0.3
        let selectionShadowOffset = CGSize(width: 0, height: 1)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 22, region: .topGutter),

            GraffeineLineLayer(id: ID.line1)
                .apply({
                    $0.unitLine.colors = [UIColor.blue]
                    $0.unitFill.colors = [UIColor.systemBlue.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                    $0.selection.line.thickness = 2.0
                    $0.selection.fill.color = UIColor.systemBlue.modifiedByAdding(alpha: -0.35)
                    $0.selection.shadow.opacity = selectionShadowOpacity
                    $0.selection.shadow.offset = selectionShadowOffset
                    $0.selection.shadow.radius = selectionShadowRadius
                    $0.selection.isEnabled = true
                }),

            GraffeineLineLayer(id: ID.line2)
                .apply({
                    $0.unitLine.colors = [UIColor.systemGreen.modifiedByAdding(brightness: -0.2)]
                    $0.unitFill.colors = [UIColor.systemGreen.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                    $0.selection.line.thickness = 2.0
                    $0.selection.fill.color = UIColor.systemGreen.modifiedByAdding(alpha: -0.35)
                    $0.selection.shadow.opacity = selectionShadowOpacity
                    $0.selection.shadow.offset = selectionShadowOffset
                    $0.selection.shadow.radius = selectionShadowRadius
                    $0.selection.isEnabled = true
                }),

            GraffeineLineLayer(id: ID.line3)
                .apply({
                    $0.unitLine.colors = [UIColor.systemOrange]
                    $0.unitFill.colors = [UIColor.systemYellow.modifiedByAdding(alpha: -0.5)]
                    $0.unitColumn.margin = unitMargin
                    $0.unitLine.thickness = 1.0
                    $0.unitLine.join = .bevel
                    $0.selection.line.thickness = 2.0
                    $0.selection.fill.color = UIColor.systemYellow.modifiedByAdding(alpha: -0.35)
                    $0.selection.shadow.opacity = selectionShadowOpacity
                    $0.selection.shadow.offset = selectionShadowOffset
                    $0.selection.shadow.radius = selectionShadowRadius
                    $0.selection.isEnabled = true
                })
        ]
    }
}
