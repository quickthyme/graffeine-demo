import UIKit
import Graffeine

class CandlestickConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, rightGutter, bottomGutter, leftGutter
        case grid, candle, wick
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let unitMargin: CGFloat = 6.0
        let vLabelInsets = UIEdgeInsets.init(top: -6, left:  0, bottom: -6, right:  0)
        let candleInsets = UIEdgeInsets.init(top:  0, left: 24, bottom:  0, right: 24)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),

            GraffeineVerticalLabelLayer(id: ID.rightGutter, width: 24, region: .rightGutter),

            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter),

            GraffeineVerticalLabelLayer(id: ID.leftGutter, width: 96, region: .leftGutter)
                .apply ({
                    $0.insets = vLabelInsets
                    $0.labelVerticalAlignmentMode = .centerTopBottom
                    $0.unitText.colors = [.systemTeal]
                    $0.unitText.fontSize = 12
                    $0.labelHPadding = 8
                }),

            GraffeineGridLineLayer(id: ID.grid)
                .apply ({
                    $0.unitLine.colors = [UIColor(white: 1.0, alpha: 0.5)]
                    $0.unitLine.thickness = 0.5
                    $0.unitLine.dashPattern = [3, 3]
                    $0.data = GraffeineData(valueMax: 10, values: Array<Int>(0...10).map {Double($0)})
                }),

            GraffeineBarLayer(id: ID.wick)
                .apply ({
                    $0.unitMargin = unitMargin
                    $0.insets = candleInsets
                    $0.unitFill.colors = [.white]
                    $0.unitSubdivision = GraffeineLayer.UnitSubdivision(index: 24, width: .percentage(0.02))
                }),

            GraffeineBarLayer(id: ID.candle)
                .apply ({
                    $0.unitMargin = unitMargin
                    $0.insets = candleInsets
                    $0.unitFill.colors = [.red]
                })
        ]
    }
}
