import UIKit
import Graffeine

class ScatterplotCell: UITableViewCell, DataAppliable {

    typealias LayerID = ScatterplotConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    var selectedIndex1: Int? = nil
    var selectedIndex2: Int? = nil
    var selectedIndex3: Int? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            if let layerId = selection?.layer.id as? LayerID,
                layerId == LayerID.vectorPlots1 {
                self.selectedIndex1 = selection?.data.selectedIndex
            }
            if let layerId = selection?.layer.id as? LayerID,
                layerId == LayerID.vectorPlots2 {
                self.selectedIndex2 = selection?.data.selectedIndex
            }
            if let layerId = selection?.layer.id as? LayerID,
                layerId == LayerID.vectorPlots3 {
                self.selectedIndex3 = selection?.data.selectedIndex
            }
            self.applyData(animated: true)
        }
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let values1: [Double?] = [nil, nil,  30, nil, nil,  36,   5, nil, nil, nil, nil, nil, nil]
        let values2: [Double?] = [  9, nil,  15, nil,   7, nil,  38, nil,   4,  27, nil,  33, nil]
        let values3: [Double?] = [nil, nil, nil,  33,  44,  25, nil,  12,  36, nil,  26,  41,  48]

        graffeineView.layer(id: LayerID.hGrid)?.apply {
            let max = values1.count - 1
            let marks = Array(0...max).map { Double($0) }
            $0.data = GraffeineData(valueMax: Double(max), values: marks)
        }

        graffeineView.layer(id: LayerID.vGrid)?.apply {
            let marks = Array(stride(from: 0.0, through: 50.0, by: 5.0))
            $0.data = GraffeineData(valueMax: 50, values: marks)
        }

        graffeineView.layer(id: LayerID.vectorPlots1)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: values1, selectedIndex: selectedIndex1)
        }

        graffeineView.layer(id: LayerID.vectorPlots2)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: values2, selectedIndex: selectedIndex2)
        }

        graffeineView.layer(id: LayerID.vectorPlots3)?.apply {
            $0.data = GraffeineData(valueMax: 50, values: values3, selectedIndex: selectedIndex3)
        }
    }
}
