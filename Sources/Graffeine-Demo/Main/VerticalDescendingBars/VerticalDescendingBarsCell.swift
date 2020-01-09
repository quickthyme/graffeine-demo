import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = VerticalDescendingBarsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values: [Double?] = [10, 9, 8, 7, 6, 5, 4, nil, 2, 1]
        let labels: [String] = values.map { ($0 == nil) ? "nil" : "\(Int($0!))" }
        if let layer = graffeineView.layer(id: LayerID.descendingBars) {
            layer.data = GraffeineLayer.Data(valueMax: 10,
                                             values: values)
        }
        if let layer = graffeineView.layer(id: LayerID.bottomGutter) {
            layer.data = GraffeineLayer.Data(labels: labels)
        }
    }
}
