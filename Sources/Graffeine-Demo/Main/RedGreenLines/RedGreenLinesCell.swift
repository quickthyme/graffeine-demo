import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DataAppliable {

    typealias LayerID = RedGreenLinesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBAction func buttonAction(_ sender: AnyObject?) {
        applyData(animated: true)
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let lineAnimator = (animated)
            ? GraffeineDataAnimators.Line.Trace(delay: 0, duration: 1.8, timing: .easeIn)
            : nil

        let projectionLineAnimator = (animated)
            ? GraffeineDataAnimators.Line.Trace(delay: 1.8, duration: 0.2, timing: .linear)
            : nil

        graffeineView.layer(id: LayerID.redLine)?
            .setData(GraffeineData(valueMax: 50, values: [4, 11, 28, 22, 29, 31, nil]),
                 animator: lineAnimator)

        graffeineView.layer(id: LayerID.redLineProj)?
            .setData(GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 31, 33]),
                     animator: projectionLineAnimator)

        graffeineView.layer(id: LayerID.greenLine)?
            .setData(GraffeineData(valueMax: 50, values: [13, 28, 33, 44, 8, 16, nil]),
                 animator: lineAnimator)

        graffeineView.layer(id: LayerID.greenLineProj)?
            .setData(GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 16, 24]),
                     animator: projectionLineAnimator)
    }
}
