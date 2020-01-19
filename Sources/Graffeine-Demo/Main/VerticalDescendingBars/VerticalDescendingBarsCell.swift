import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = VerticalDescendingBarsConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    let dataSets: [[Double?]] = [
        [10, 9, 8, nil, 6, 5, 4, 3, 2,  1],
        [ 1, 2, 3,   4, 5, 6, 7, 8, 9, 10]
    ]

    var dataSetIndex: Int = 0

    func applyData() {
        let values: [Double?] = dataSets[dataSetIndex]
        let labels: [String] = values.map { ($0 == nil) ? "?" : "\(Int($0!))" }

        graffeineView.layer(id: LayerID.descendingBars)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 10, values: values)
        }

        graffeineView.layer(id: LayerID.bottomGutter)?.apply {
            $0.data = GraffeineLayer.Data(labels: labels)
        }
    }


    // Press the button to animate data changes
    @IBAction func buttonAction(_ sender: AnyObject?) {

        // Each button press cycles which data set is being displayed
        dataSetIndex = (dataSetIndex + 1) % dataSets.count

        let values: [Double?] = dataSets[dataSetIndex]
        let labels: [String] = values.map { ($0 == nil) ? "?" : "\(Int($0!))" }

        // Use `setData(_:animated:)` instead of assignment whenever animation is desired
        graffeineView.layer(id: LayerID.descendingBars)!
            .setData(GraffeineLayer.Data(valueMax: 10, values: values),
                     animator: GraffeineDataAnimators.Bar.Grow(duration: 2.0,
                                                               timing: .easeInEaseOut))

        graffeineView.layer(id: LayerID.bottomGutter)?
            .setData(GraffeineLayer.Data(labels: labels),
                     animator: nil)
    }
}
