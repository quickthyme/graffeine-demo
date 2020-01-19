import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DataAppliable {

    typealias LayerID = RedGreenLinesConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        graffeineView.layer(id: LayerID.redLine)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: [4, 11, 28, 22, 29, 31, nil])
        }

        graffeineView.layer(id: LayerID.redLineProj)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 31, 33])
        }

        graffeineView.layer(id: LayerID.greenLine)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: [13, 28, 33, 44, 8, 16, nil])
        }

        graffeineView.layer(id: LayerID.greenLineProj)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: [nil, nil, nil, nil, nil, 16, 24])
        }
    }
}
