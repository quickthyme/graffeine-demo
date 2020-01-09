import UIKit
import Graffeine

class HorizontalGroupedBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = HorizontalGroupedBarsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values1: [Double?] = [2, 4, 6, 8, 10, 12, 14, 16]
        let values2: [Double?] = [7, 1, 5, 3, 11, 13, 10, 4]
        let vLabels: [String]   = ["A", "B", "C", "D", "E", "F", "G", "H"]
        let hLabels: [String]   = ["2", "4", "6", "8", "10", "12", "14", "16", "18", "20"]

        graffeineView.layer(id: LayerID.bars1)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 20, values: values1)
        }

        graffeineView.layer(id: LayerID.bars2)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 20, values: values2)
        }

        graffeineView.layer(id: LayerID.leftGutter)?.apply {
            $0.data = GraffeineLayer.Data(labels: vLabels)
        }

        graffeineView.layer(id: LayerID.bottomGutter)?.apply {
            $0.data = GraffeineLayer.Data(labels: hLabels)
        }
    }
}
