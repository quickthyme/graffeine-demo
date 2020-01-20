import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    // Press the button to animate data changes
    @IBAction func buttonAction(_ sender: AnyObject?) {

        // Each button press cycles which data set is being displayed
        dataSetIndex = (dataSetIndex + 1) % dataSets.count
        applyDataAnimated()
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
