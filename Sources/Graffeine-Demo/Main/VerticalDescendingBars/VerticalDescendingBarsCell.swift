import UIKit
import Graffeine

class VerticalDescendingBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = VerticalDescendingBarsConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = {
            self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
            self.applyData(animated: true)
        }
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Bar.Grow(duration: 2.0, timing: .easeInEaseOut)
            : nil
    }

    let dataSets: [[Double?]] = [
        [10, 9, 8, nil, 6, 5, 4, 3, 2,  1],
        [ 1, 2, 3,   4, 5, 6, 7, 8, 9, 10]
    ]

    var dataSetIndex: Int = 0

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let values: [Double?] = dataSets[dataSetIndex]
        let labels: [String] = values.map { ($0 == nil) ? "?" : "\(Int($0!))" }

        graffeineView.layer(id: LayerID.descendingBars)!
            .setData(GraffeineData(valueMax: 10, values: values),
                     animator: barAnimator(animated))

        graffeineView.layer(id: LayerID.bottomGutter)?
            .setData(GraffeineData(labels: labels),
                     animator: nil)
    }
}
