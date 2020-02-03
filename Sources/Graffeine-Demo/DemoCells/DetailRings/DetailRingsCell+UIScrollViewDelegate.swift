import UIKit
import Graffeine

extension DetailRingsCell: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        ensureContentCenteredWhenSmall(scrollView)
        manageLayerTransitions(scrollView)
    }

    func ensureContentCenteredWhenSmall(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }

    func manageLayerTransitions(_ scrollView: UIScrollView) {
        let pctZoomed: CGFloat = (scrollView.zoomScale / scrollView.maximumZoomScale)
        manageCenterToRing1Transition(pctZoomed)
        manageRing1ToRing2Transitions(pctZoomed)
    }

    func manageCenterToRing1Transition(_ pctZoomed: CGFloat) {
        let opacity = getOpacityValue(pctZoomed, marginStart: 0.20, marginStop: 0.70)
        graffeineView.layer(id: LayerID.center)?.selection.isEnabled = (opacity < 0.70)
        graffeineView.layer(id: LayerID.ring1)?.opacity = Float(opacity)
        graffeineView.layer(id: LayerID.ring1Labels)?.opacity = Float(opacity)
    }

    func manageRing1ToRing2Transitions(_ pctZoomed: CGFloat) {
        let opacity = getOpacityValue(pctZoomed, marginStart: 0.40, marginStop: 0.40)
        graffeineView.layer(id: LayerID.ring1)?.selection.isEnabled = (opacity < 0.75)
        graffeineView.layer(id: LayerID.ring2)?.opacity = Float(opacity)
        graffeineView.layer(id: LayerID.ring2Labels)?.opacity = Float(opacity)
    }

    func getOpacityValue(_ pctZoomed: CGFloat, marginStart: CGFloat, marginStop: CGFloat) -> CGFloat {
        return (pctZoomed > marginStart)
            ? max(((pctZoomed - marginStart) / (1.0 - marginStop - marginStart)), 0)
            : 0.0
    }
}
