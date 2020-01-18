import UIKit
import Graffeine

class LinePointsCell: UITableViewCell, DataAppliable {

    typealias LayerID = LinePointsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    // Press the button to animate data changes
    @IBAction func buttonAction(_ sender: AnyObject?) {

        // Each button press cycles which data set is being displayed
        dataSetIndex = (dataSetIndex + 1) % dataSets.count

        // Use `setData(_:animated:)` instead of assignment whenever animation is desired
        graffeineView.layer(id: LayerID.line)!.setData(lineAndPointData,
                                                       animated: true,
                                                       duration: 2.0,
                                                       timing: .easeInEaseOut)

        graffeineView.layer(id: LayerID.points)!.setData(lineAndPointData,
                                                         animated: true,
                                                         duration: 2.0,
                                                         timing: .easeInEaseOut)

        graffeineView.layer(id: LayerID.bottomGutter)?.setData(labelData,
                                                               animated: true,
                                                               duration: 2.0,
                                                               timing: .easeInEaseOut)
    }

    let dataSets: [[Double]] = [
        [1, 1, 2, 3, 5, 8, 13, 21, 34],
        [2, 0, 3, 1, 4, 2, 5, 3, 6, 4, 7, 5, 8, 6, 9, 7, 10],
        [5, 3, 4, 2, 1, 2, 6]
    ]

    var dataSetIndex: Int = 0

    var lineAndPointData: GraffeineLayer.Data {
        let values = dataSets[dataSetIndex]
        return GraffeineLayer.Data(valueMax: values.max()!, values: values + [nil])
    }

    var labelData: GraffeineLayer.Data {
        let values = dataSets[dataSetIndex]
        return GraffeineLayer.Data(labels: values.map { String(Int($0)) })
    }

    func applyData() {
        graffeineView.layer(id: LayerID.line)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.points)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.bottomGutter)?.data = labelData
    }
}
