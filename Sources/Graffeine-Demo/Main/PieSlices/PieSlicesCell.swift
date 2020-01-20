import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = {
            self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
            self.applyDataAnimated()
        }
    }

    let dataSets: [[Double]] = [
        [10, 8, 4, 22, 16, 14],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [1, 1, 2, 3, 5, 8, 13, 21, 34]
    ]

    var dataSetIndex: Int = 0

    func getData() -> GraffeineData {
        let dataSet = dataSets[dataSetIndex]
        let labels: [String?] = dataSet.map { String(Int($0)) }
        return GraffeineData(valueMax: 100, values: dataSets[dataSetIndex], labels: labels)
    }

    func getRandomPieAnimator() -> GraffeinePieDataAnimating {
        switch (Int.random(in: 0...3)) {
        case 3:  return GraffeineDataAnimators.Pie.Spin(duration: 1.2, timing: .easeInEaseOut)
        default: return GraffeineDataAnimators.Pie.Automatic(duration: 1.2, timing: .easeInEaseOut)
        }
    }

    func applyData() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?.data = newData
        graffeineView.layer(id: LayerID.pieLabels)?.data = newData
    }

    func applyDataAnimated() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?.setData(newData, animator: getRandomPieAnimator())
        graffeineView.layer(id: LayerID.pieLabels)?
            .setData(newData, animator:
                GraffeineDataAnimators.RadialLabel.FadeIn(duration: 1.2,
                                                          timing: .easeInEaseOut,
                                                          delayRatio: 0.94))
    }
}
