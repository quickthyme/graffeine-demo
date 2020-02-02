import UIKit
import Graffeine

class DetailRingsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case ring1, labels1
        case ring2, labels2
    }

    let colors: [UIColor] = [
        UIColor.white,
        UIColor.systemGray4,
        UIColor.systemGray
    ]

    let colors2: [UIColor] = [
        UIColor(white: 0.9, alpha: 0.5),
        UIColor(white: 0.3, alpha: 0.5)
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.ring1)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.outerDiameter = .percentage(0.60)
                    $0.innerDiameter = .percentage(0.40)
                    $0.unitFill.colors = colors
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 0.5
                    $0.selection.isEnabled = true
                }),

            GraffeineRadialLabelLayer(id: ID.labels1)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.diameter = .percentage(0.75)
                    $0.unitText.colors = [.darkGray]
                    $0.unitText.fontSize = 16
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .black
                }),

            GraffeineRadialSegmentLayer(id: ID.ring2)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.outerDiameter = .percentage(0.60)
                    $0.innerDiameter = .percentage(0.40)
                    $0.unitFill.colors = colors2
                    $0.unitLine.colors = [.black]
                    $0.unitLine.thickness = 0.10
                    $0.selection.isEnabled = true
                    $0.opacity = 0.0
                }),

            GraffeineRadialLabelLayer(id: ID.labels2)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.diameter = .percentage(0.650)
                    $0.unitText.colors = [.darkGray]
                    $0.unitText.fontSize = 4
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .black
                    $0.opacity = 0.0
                    $0.shouldRasterize = true
                    $0.rasterizationScale = UIScreen.main.scale * 8
                })
        ]
    }
}
