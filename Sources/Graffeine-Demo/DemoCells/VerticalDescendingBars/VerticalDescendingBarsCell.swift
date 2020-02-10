import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DemoCell {

    typealias LayerID = VerticalDescendingBarsConfig.ID
    typealias AnimationKey = VerticalDescendingBarsConfig.AnimationKey

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
            self.selectedIndex = selection?.data.selected.index
            self.applyData(animated: true)
        }
    }

    let dataSets: [[Double?]] = [
        [8, 7, 6, 5, 4, 3, 2,  1],
        [ 1, 2, 3, 4, 5, 6, 7, 8]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let valuesHi: [Double?] = dataSets[dataSetIndex]
        let data = GraffeineData(valuesHi: valuesHi,
                                 labels: valuesHi.map { ($0 == nil) ? "?" : "\(Int($0!))" },
                                 selectedIndex: selectedIndex)

        let animationKeys = (animated)
            ? (bar: AnimationKey.bar, label: AnimationKey.barLabel)
            : nil

        graffeineView.layer(id: LayerID.bottomGutter)?.setData(data, animationKey: nil)
        graffeineView.layer(id: LayerID.bar)!.setData(data, animationKey: animationKeys?.bar)
        graffeineView.layer(id: LayerID.barLabel)!.setData(data, animationKey: animationKeys?.label)
    }
}
