import UIKit
import Graffeine

class DetailRingsCell: UITableViewCell, DemoCell {

    typealias LayerID = DetailRingsConfig.ID

    var data = DetailRingsData()

    @IBOutlet weak var graffeineView: GraffeineView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.zoomScale = scrollView.minimumZoomScale
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        graffeineView.bounds.size = CGSize(width: 600, height: 600)
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
        let pctZoomed: CGFloat = (scrollView.zoomScale / scrollView.maximumZoomScale)
        let opacityMarginStart: CGFloat = 0.20
        let opacityMarginStop: CGFloat = 0.50

        let opacity = (pctZoomed > opacityMarginStart)
            ? max(((pctZoomed - opacityMarginStart) / (1.0 - opacityMarginStop - opacityMarginStart)), 0)
            : 0.0

        graffeineView.layer(id: LayerID.ring2)?.opacity = Float(opacity)
        graffeineView.layer(id: LayerID.labels2)?.opacity = Float(opacity)
    }
}
