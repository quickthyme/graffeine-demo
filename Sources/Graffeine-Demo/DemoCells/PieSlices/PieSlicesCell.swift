import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DemoCell {

    typealias LayerID = PieSlicesConfig.ID

    var data = PieSlicesData()

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.data.incrementDataSetIndex()
        self.applyDataAnimated()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .diagonalLines
        setupSelection()
    }

    func setupSelection() {
        graffeineView.onSelect = { selection in
            self.data.selectedIndex = selection?.data.selected.index
            self.applySelectionAnimated()
        }
    }

    func getRandomPieAnimator() -> GraffeineRadialSegmentDataAnimating {
        switch (Int.random(in: 0...2)) {
        case 2:  return GraffeineAnimation.Data.RadialSegment.Spin(duration: 1.2, timing: .easeInEaseOut)
        default: return GraffeineAnimation.Data.RadialSegment.Automatic(duration: 1.2, timing: .easeInEaseOut)
        }
    }

    func getLabelAnimator() -> GraffeineRadialLabelDataAnimating {
        return GraffeineAnimation.Data.RadialLabel.FadeIn(duration: 1.2,
                                                          timing: .easeInEaseOut,
                                                          delayRatio: 0.94)
    }

    func getLineAnimator() -> GraffeineRadialLineDataAnimating {
        return GraffeineAnimation.Data.RadialLine.FadeIn(duration: 1.2,
                                                         timing: .easeInEaseOut,
                                                         delayRatio: 0.94)
    }

    func applyData() {
        let newData = data.get()
        graffeineView.layer(id: LayerID.pie)?.data = newData
        graffeineView.layer(id: LayerID.labels)?.data = newData
        graffeineView.layer(id: LayerID.labelLines)?.data = newData
    }

    func applyDataAnimated() {
        let newData = data.get()
        graffeineView.layer(id: LayerID.pie)?
            .setData(newData, animator: getRandomPieAnimator())

        graffeineView.layer(id: LayerID.labels)?
            .setData(newData, animator: getLabelAnimator())

        graffeineView.layer(id: LayerID.labelLines)?
            .setData(newData, animator: getLineAnimator())
    }

    func applySelectionAnimated() {
        let newData = data.get()
        graffeineView.layer(id: LayerID.pie)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialSegment.Morph(duration: 0.22,
                                                                  timing: .linear))

        graffeineView.layer(id: LayerID.labels)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialLabel.Move(duration: 0.22,
                                                               timing: .linear,
                                                               delayRatio: 0))

        graffeineView.layer(id: LayerID.labelLines)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialLine.Move(duration: 0.22,
                                                              timing: .linear))
    }
}

extension PieSlicesCell: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}
