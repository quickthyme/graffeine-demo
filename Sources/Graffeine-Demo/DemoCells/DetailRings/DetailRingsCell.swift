import UIKit
import Graffeine

class DetailRingsCell: UITableViewCell, DemoCell {

    typealias LayerID = DetailRingsConfig.ID

    var data = DetailRingsData()

    @IBOutlet weak var graffeineView: GraffeineView!
    @IBOutlet weak var scrollView: UIScrollView!

    var selectedIndex: Int? = nil
    var selectedLayerID: LayerID? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "paper")!)
        scrollView.zoomScale = scrollView.minimumZoomScale
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
            self.selectedLayerID = selection?.layer.id as? LayerID
            self.applyData()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        graffeineView.bounds.size = CGSize(width: 600, height: 600)
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

extension DetailRingsCell: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)

        let pctZoomed: CGFloat = (scrollView.zoomScale / scrollView.maximumZoomScale)
        let opacityMarginStart: CGFloat = 0.30
        let opacityMarginStop: CGFloat = 0.50

        let opacity = (pctZoomed > opacityMarginStart)
            ? max(((pctZoomed - opacityMarginStart) / (1.0 - opacityMarginStop - opacityMarginStart)), 0)
            : 0.0

        graffeineView.layer(id: LayerID.center)?.selection.isEnabled = (opacity < 0.8)
        graffeineView.layer(id: LayerID.ring1)?.selection.isEnabled = (opacity < 0.8)

        graffeineView.layer(id: LayerID.ring2)?.opacity = Float(opacity)
        graffeineView.layer(id: LayerID.ring2Labels)?.opacity = Float(opacity)
    }
}
