import UIKit
import Graffeine

class LinePointsCell: UITableViewCell, DataAppliable {

    typealias LayerID = LinePointsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values: [Double] = [1, 1, 2, 3, 5, 8, 13, 21, 34]
        let maxValue = values.max()!

        graffeineView.layer(id: LayerID.line)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: maxValue, values: values + [nil])
        }

        graffeineView.layer(id: LayerID.points)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: maxValue, values: values + [nil])
        }

        graffeineView.layer(id: LayerID.bottomGutter)?.apply {
            $0.data = GraffeineLayer.Data(labels: values.map { String(Int($0)) })
        }
    }
}
