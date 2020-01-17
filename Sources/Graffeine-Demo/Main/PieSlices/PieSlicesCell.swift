import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values: [Double?] = [10, 8, 4, 22, 16, 14]

        graffeineView.layer(id: LayerID.pie)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 100, values: values)
        }
    }
}
