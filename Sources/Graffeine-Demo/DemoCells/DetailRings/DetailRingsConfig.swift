import UIKit
import Graffeine

class DetailRingsConfig: GraffeineViewConfig {

    enum ID: Hashable {
        case center, centerLabels
        case ring1, ring1Labels
        case ring2, ring2Labels
    }

    let colors0: [UIColor] = [
        .systemRed,
        .systemYellow,
        .systemBlue,
        .systemGreen,
        .systemTeal
    ]

    let colors1: [UIColor] = [
        .systemRed, .systemRed,
        .systemYellow, .systemYellow,
        .systemBlue, .systemBlue,
        .systemGreen, .systemGreen,
        .systemTeal, .systemTeal
    ]

    let colors2: [UIColor] = [
        UIColor(white: 0.91, alpha: 0.44),
        UIColor(white: 0.44, alpha: 0.44)
    ]

    required init(_ graffeineView: GraffeineView) {
        super.init(graffeineView)

        graffeineView.layers = [

            GraffeineRadialSegmentLayer(id: ID.center)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.outerDiameter = .percentage(0.65)
                    $0.innerDiameter = .percentage(0.15)
                    $0.unitFill.colors = colors0
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.5
                    $0.shadowColor = UIColor.black.cgColor
                    $0.shadowOpacity = 0.5
                    $0.shadowRadius = 2.0
                    $0.shadowOffset = CGSize(width: 0, height: 1.0)
                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(brightness: -0.5) }
                }),

            GraffeineRadialLabelLayer(id: ID.centerLabels)
                .apply ({
                    $0.clockwise = true
                    $0.centerRotation = 180
                    $0.diameter = .percentage(0.40)
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 30
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .white
                }),

            GraffeineRadialSegmentLayer(id: ID.ring1)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.outerDiameter = .percentage(0.65)
                    $0.innerDiameter = .percentage(0.15)
                    $0.unitFill.colors = colors1
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.5
                    $0.selection.isEnabled = true
                    $0.selection.fill.modifyColor = { $0?.modifiedByAdding(brightness: -0.5) }
                    $0.opacity = 0.0
                }),

            GraffeineRadialSegmentLayer(id: ID.ring2)
                .apply ({
                    $0.clockwise = true
                    $0.rotation = 180
                    $0.outerDiameter = .percentage(0.65)
                    $0.innerDiameter = .percentage(0.15)
                    $0.unitFill.colors = colors2
                    $0.unitLine.colors = [.label]
                    $0.unitLine.thickness = 0.10
                    $0.selection.isEnabled = true
                    $0.selection.fill.color = .blackAlpha
                    $0.opacity = 0.0
                }),

            GraffeineRadialLabelLayer(id: ID.ring1Labels)
                .apply ({
                    $0.clockwise = true
                    $0.centerRotation = 180
                    $0.diameter = .percentage(0.50)
                    $0.unitText.colors = [.label]
                    $0.unitText.fontSize = 20
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .inverseLabel
                    $0.opacity = 0.0
                }),

            GraffeineRadialLabelLayer(id: ID.ring2Labels)
                .apply ({
                    $0.clockwise = true
                    $0.centerRotation = 180
                    $0.labelRotation = -90
                    $0.labelRotationInheritFromCenter = true
                    $0.diameter = .percentage(0.68)
                    $0.unitText.colors = [.systemGray]
                    $0.unitText.fontSize = 8
                    $0.labelAlignment.horizontal = .center
                    $0.labelAlignment.vertical = .center
                    $0.selection.text.color = .label
                    $0.opacity = 0.0
                })
        ]
    }
}
