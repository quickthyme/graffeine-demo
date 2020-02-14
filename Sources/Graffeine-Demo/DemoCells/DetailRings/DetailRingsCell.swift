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
        self.contentView.backgroundColor = .diagonalLines
        scrollView.zoomScale = scrollView.minimumZoomScale
    }

    func setupSelection() {
        graffeineView.onSelect = { _, selection in
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
        DispatchQueue.global(qos: .background).async {
            let layerIndex = self.getLayerIndex(self.selectedLayerID)
            let newData = self.data.get(selectedIndex: self.selectedIndex,
                                        selectedLayerIndex: layerIndex)

            DispatchQueue.main.async {
                self.graffeineView.layer(id: LayerID.center)?.data = newData.0
                self.graffeineView.layer(id: LayerID.centerLabels)?.data = newData.0

                self.graffeineView.layer(id: LayerID.ring1)?.data = newData.1
                self.graffeineView.layer(id: LayerID.ring1Labels)?.data = newData.1

                self.graffeineView.layer(id: LayerID.ring2)?.data = newData.2
                self.graffeineView.layer(id: LayerID.ring2Labels)?.data = newData.2
            }
        }
    }
}
