import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DataAppliable {

    typealias LayerID = RedGreenLinesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { _ in
            self.applyData(animated: true)
        }
    }

    func applyData() {
        applyData(animated: false)
    }

    func lineAnimator(_ animated: Bool) -> GraffeineLineDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Line.Trace(delay: 0, duration: 1.8, timing: .easeIn)
            : nil
    }

    func projectionLineAnimator(_ animated: Bool) -> GraffeineLineDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Line.Trace(delay: 1.8, duration: 0.2, timing: .linear)
            : nil
    }

    func applyData(animated: Bool) {

        graffeineView.layer(id: LayerID.redLine)?
            .setData(GraffeineData(valueMax: 50, values: [4, 11, 28, 22, 29, 31, nil]),
                 animator: lineAnimator(animated))

        graffeineView.layer(id: LayerID.redLineProj)?
            .setData(GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 31, 33]),
                     animator: projectionLineAnimator(animated))

        graffeineView.layer(id: LayerID.greenLine)?
            .setData(GraffeineData(valueMax: 50, values: [13, 28, 33, 44, 8, 16, nil]),
                 animator: lineAnimator(animated))

        graffeineView.layer(id: LayerID.greenLineProj)?
            .setData(GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 16, 24]),
                     animator: projectionLineAnimator(animated))
    }
}
