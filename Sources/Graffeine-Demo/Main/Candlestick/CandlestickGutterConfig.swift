import UIKit
import Graffeine

class CandlestickGutterConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case topGutter, bottomGutter, mainGutter
    }

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        let vLabelInsets = UIEdgeInsets.init(top: -12, left:  0, bottom: -10, right:  0)

        graffeineView.layers = [

            GraffeineHorizontalLabelLayer(id: ID.topGutter, height: 24, region: .topGutter),
            GraffeineHorizontalLabelLayer(id: ID.bottomGutter, height: 24, region: .bottomGutter),
            GraffeineVerticalLabelLayer(id: ID.mainGutter, width: 64, region: .main)
                .apply ({
                    $0.insets = vLabelInsets
                    $0.labelAlignment.horizontal = .right
                    $0.labelAlignment.vertical = .center
                    $0.unitText.colors = [.systemTeal]
                    $0.unitText.fontSize = 12
                    $0.labelPadding.horizontal = 8
                })
        ]
    }
}
