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
        graffeineView.onSelect = { _, selection in
            self.data.selectedIndex = selection?.data.selected.index
            self.applySelectionAnimated()
        }
    }

    func getRandomPieAnimationSemantic() -> GraffeineData.AnimationSemantic {
        switch (Int.random(in: 0...2)) {
        case 2:  return .next
        default: return .reload
        }
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
            .setData(newData, semantic: getRandomPieAnimationSemantic())

        graffeineView.layer(id: LayerID.labels)?
            .setData(newData, semantic: .reload)

        graffeineView.layer(id: LayerID.labelLines)?
            .setData(newData, semantic: .reload)
    }

    func applySelectionAnimated() {
        let newData = data.get()
        graffeineView.layer(id: LayerID.pie)?
            .setData(newData, semantic: .select)

        graffeineView.layer(id: LayerID.labels)?
            .setData(newData, semantic: .select)

        graffeineView.layer(id: LayerID.labelLines)?
            .setData(newData, semantic: .select)
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
