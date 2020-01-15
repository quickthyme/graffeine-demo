import UIKit
import Graffeine

class ScatterplotCell: UITableViewCell, DataAppliable {

    typealias LayerID = ScatterplotConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    func applyData() {
        let values: [Double?] = [0, 10, 30, nil, 20, 40, 5, 30, 25, 45, 10, 25, 50]
        graffeineView.layer(id: LayerID.hGrid)?.apply {
            let max = values.count - 1
            let marks = Array(0...max).map { Double($0) }
            $0.data = GraffeineLayer.Data(valueMax: Double(max), values: marks)
        }

        graffeineView.layer(id: LayerID.vGrid)?.apply {
            let marks = Array(stride(from: 0.0, through: 50.0, by: 5.0))
            $0.data = GraffeineLayer.Data(valueMax: 50, values: marks)
        }

        graffeineView.layer(id: LayerID.vectorPlots)?.apply {
            $0.data = GraffeineLayer.Data(valueMax: 50, values: values)
        }
    }
}
