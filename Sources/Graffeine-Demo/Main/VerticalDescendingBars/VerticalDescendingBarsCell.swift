import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = VerticalDescendingBarsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values: [Double?] = [10, 9, 8, 7, 6, 5, 4, nil, 2, 1]
        let labels: [String] = values.map { ($0 == nil) ? "nil" : "\(Int($0!))" }

        graffeineView.layer(id: LayerID.descendingBars)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 10, values: values)
        }

        graffeineView.layer(id: LayerID.bottomGutter)?.apply {
            $0.data = GraffeineLayer.Data(labels: labels)
        }
    }
}
