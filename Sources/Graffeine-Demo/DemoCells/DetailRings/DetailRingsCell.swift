import UIKit
import Graffeine

class DetailRingsCell: UITableViewCell, DemoCell {

    typealias LayerID = DetailRingsConfig.ID

    var data = DetailRingsData()

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func applyData() {
        let newData = data.get()
        graffeineView.layer(id: LayerID.ring1)?.data = newData.0
        graffeineView.layer(id: LayerID.labels1)?.data = newData.0
        graffeineView.layer(id: LayerID.ring2)?.data = newData.1
        graffeineView.layer(id: LayerID.labels2)?.data = newData.1
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

        let pctZoomed = Float((scrollView.zoomScale - 1.5) / scrollView.maximumZoomScale)
        let pctReveal = max(min(pctZoomed, 1.0), 0.0)
        graffeineView.layer(id: LayerID.ring2)?.opacity = pctReveal
        graffeineView.layer(id: LayerID.labels2)?.opacity = pctReveal
    }
}
