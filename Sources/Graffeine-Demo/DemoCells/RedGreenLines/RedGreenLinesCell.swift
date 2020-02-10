import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DemoCell {

    typealias LayerID = RedGreenLinesConfig.ID
    typealias AnimationKey = RedGreenLinesConfig.AnimationKey

    @IBOutlet weak var graffeineView: GraffeineView!

    var data: Data = Data()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.regenerateData()
        graffeineView.onSelect = { _ in
            self.regenerateData()
            self.applyData(animated: true)
        }
    }

    func regenerateData() {
        self.data = Data.generateRandom()
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let data = self.data

        let animationKeys = (animated)
            ? (historicalLine: AnimationKey.historicalLine,
               projectionLine: AnimationKey.projectionLine)
            : nil

        graffeineView.layer(id: LayerID.redLineProj)?
            .setData(GraffeineData(valueMax: 50, valuesHi: data.redProjected),
                     animationKey: animationKeys?.projectionLine)

        graffeineView.layer(id: LayerID.redLine)?
            .setData(GraffeineData(valueMax: 50, valuesHi: data.redHistorical + [nil]),
                     animationKey: animationKeys?.historicalLine)

        graffeineView.layer(id: LayerID.greenLineProj)?
            .setData(GraffeineData(valueMax: 50, valuesHi: data.greenProjected),
                     animationKey: animationKeys?.projectionLine)

        graffeineView.layer(id: LayerID.greenLine)?
            .setData(GraffeineData(valueMax: 50, valuesHi: data.greenHistorical + [nil]),
                 animationKey: animationKeys?.historicalLine)
    }
}
