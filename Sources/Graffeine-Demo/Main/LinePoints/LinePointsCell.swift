import UIKit
import Graffeine

class LinePointsCell: UITableViewCell, DataAppliable {

    typealias LayerID = LinePointsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = {
            self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
            self.applyDataAnimated()
        }
    }

    let dataSets: [[Double]] = [
        [1, 1, 2, 3, 5, 8, 13, 21, 34],
        [2, 0, 3, 1, 4, 2, 5, 3, 6, 4, 7, 5, 8, 6, 9, 7, 10],
        [5, 3, 4, 2, 1, 2, 6]
    ]

    var dataSetIndex: Int = 0

    var lineAndPointData: GraffeineData {
        let values = dataSets[dataSetIndex]
        return GraffeineData(valueMax: values.max()!, values: values + [nil])
    }

    var labelData: GraffeineData {
        let values = dataSets[dataSetIndex]
        return GraffeineData(labels: values.map { String(Int($0)) })
    }

    func applyData() {
        graffeineView.layer(id: LayerID.line)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.points)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.bottomGutter)?.data = labelData
    }

    func applyDataAnimated() {
        graffeineView.layer(id: LayerID.line)!.setData(lineAndPointData, animator:
            GraffeineDataAnimators.Line.Morph(duration: 2.0,
                                              timing: .easeInEaseOut))

        graffeineView.layer(id: LayerID.points)!
            .setData(lineAndPointData, animator:
                GraffeineDataAnimators.Plot.FadeIn(duration: 2.0,
                                                   timing: .easeInEaseOut,
                                                   delayRatio: 0.99))

        graffeineView.layer(id: LayerID.bottomGutter)?.setData(labelData, animator: nil)
    }
}
