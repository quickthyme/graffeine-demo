import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = VerticalDescendingBarsConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelection()
    }

    func setupSelection() {
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            self.applyData(animated: true)
        }
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Bar.Grow(duration: 0.88, timing: .easeInEaseOut)
            : nil
    }

    func barLabelAnimator(_ animated: Bool) -> GraffeineLabelDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Label.Slide(duration: 0.88, timing: .easeInEaseOut)
            : nil
    }

    let dataSets: [[Double?]] = [
        [10, 9, 8, nil, 6, 5, 4, 3, 2,  1],
        [ 1, 2, 3,   4, 5, 6, 7, 8, 9, 10]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let values: [Double?] = dataSets[dataSetIndex]
        let data = GraffeineData(valueMax: 10,
                                 values: values,
                                 labels: values.map { ($0 == nil) ? "?" : "\(Int($0!))" },
                                 selectedIndex: selectedIndex)

        graffeineView.layer(id: LayerID.bottomGutter)?
            .setData(data, animator: nil)

        graffeineView.layer(id: LayerID.bar)!
            .setData(data, animator: barAnimator(animated))

        graffeineView.layer(id: LayerID.barLabel)!
            .setData(data, animator: barLabelAnimator(animated))
    }
}
