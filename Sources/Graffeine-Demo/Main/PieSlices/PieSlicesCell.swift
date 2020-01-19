import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    // Press the button to animate data changes
    @IBAction func buttonAction(_ sender: AnyObject?) {

        // Each button press cycles which data set is being displayed
        dataSetIndex = (dataSetIndex + 1) % dataSets.count

        let pieLayer = graffeineView.layer(id: LayerID.pie)!
        let newData = GraffeineData(valueMax: 100,
                                          values: dataSets[dataSetIndex])

        // Use `setData(_:animator:)` instead of assignment whenever animation is desired
        pieLayer.setData(newData, animator: getRandomPieAnimator())
    }

    let dataSets: [[Double]] = [
        [10, 8, 4, 22, 16, 14],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [1, 1, 2, 3, 5, 8, 13, 21, 34]
    ]

    var dataSetIndex: Int = 0

    func getRandomPieAnimator() -> GraffeinePieDataAnimating {
        switch (Int.random(in: 0...3)) {
        case 3:  return GraffeineDataAnimators.Pie.Spin(duration: 1.2, timing: .easeInEaseOut)
        default: return GraffeineDataAnimators.Pie.Automatic(duration: 1.2, timing: .easeInEaseOut)
        }
    }

    func applyData() {
        graffeineView.layer(id: LayerID.pie)?
            .data = GraffeineData(valueMax: 100, values: dataSets[dataSetIndex])
    }
}
