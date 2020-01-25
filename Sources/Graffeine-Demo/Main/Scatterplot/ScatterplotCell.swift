import UIKit
import Graffeine

class ScatterplotCell: UITableViewCell, DataAppliable {

    typealias LayerID = ScatterplotConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    var selectedLayer: LayerID? = nil
    var selectedIndex: Int? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            self.selectedLayer = selection?.layer.id as? LayerID
            self.applyData(animated: true)
        }
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let values: [[Double?]] = [
            [nil, nil,  30, nil, nil,  36,   5, nil, nil, nil, nil, nil, nil],
            [  9, nil,  15, nil,   7, nil,  38, nil,   4,  27, nil,  33, nil],
            [nil, nil, nil,  33,  44,  25, nil,  12,  36, nil,  26,  41,  48]
        ]

        graffeineView.layer(id: LayerID.vectorPlots1)?.apply {
            $0.data = GraffeineData(
                valueMax: 50,
                values: values[0],
                selectedIndex: (selectedLayer == .vectorPlots1) ? selectedIndex : nil)
        }

        graffeineView.layer(id: LayerID.vectorPlots2)?.apply {
            $0.data = GraffeineData(
                valueMax: 50,
                values: values[1],
                selectedIndex: (selectedLayer == .vectorPlots2) ? selectedIndex : nil)
        }

        graffeineView.layer(id: LayerID.vectorPlots3)?.apply {
            $0.data = GraffeineData(
                valueMax: 50,
                values: values[2],
                selectedIndex: (selectedLayer == .vectorPlots3) ? selectedIndex : nil)
        }
    }
}
