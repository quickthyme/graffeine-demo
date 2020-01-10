import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DataAppliable {

    typealias LayerID = RedGreenLinesConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        graffeineView.layer(id: LayerID.redLine)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 50, values: [4, 11, 28, 22, 29, 31, nil])
        }

        graffeineView.layer(id: LayerID.greenLine)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 50, values: [13, 28, 33, 44, 9, 18, nil])
        }
    }
}
