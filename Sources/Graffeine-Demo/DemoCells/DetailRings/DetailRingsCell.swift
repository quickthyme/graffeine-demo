import UIKit
import Graffeine

class DetailRingsCell: UITableViewCell, DemoCell {

    typealias LayerID = DetailRingsConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!
    @IBOutlet weak var scrollView: UIScrollView!

    var data = DetailRingsData()
    var selectedIndex: Int? = nil
    var selectedLayerID: LayerID? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainers()
        setupSelection()
    }

    func setupContainers() {
        let pattern = UIImage(named: "diagonal_lines")!
        self.contentView.backgroundColor = UIColor(patternImage: pattern)
        scrollView.zoomScale = scrollView.minimumZoomScale
    }

    func setupSelection() {
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
            self.selectedLayerID = selection?.layer.id as? LayerID
            self.applyData()
        }
    }

    let layerIndexMap: [LayerID: Int] = [
        LayerID.center: 0,
        LayerID.ring1:  1,
        LayerID.ring2:  2
    ]

    func getLayerIndex(_ layerID: LayerID?) -> Int? {
        guard let layerID = layerID else { return nil }
        return layerIndexMap[layerID]
    }

    func applyData() {
        let layerIndex = getLayerIndex(selectedLayerID)
        let newData = data.get(selectedIndex: selectedIndex,
                               selectedLayerIndex: layerIndex)

        graffeineView.layer(id: LayerID.center)?.data = newData.0
        graffeineView.layer(id: LayerID.centerLabels)?.data = newData.0

        graffeineView.layer(id: LayerID.ring1)?.data = newData.1
        graffeineView.layer(id: LayerID.ring1Labels)?.data = newData.1

        graffeineView.layer(id: LayerID.ring2)?.data = newData.2
        graffeineView.layer(id: LayerID.ring2Labels)?.data = newData.2
    }
}
