import UIKit
import Graffeine

class HorizontalGroupedBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = HorizontalGroupedBarsConfig.ID
    
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
            ? GraffeineDataAnimators.Bar.Grow(duration: 0.8, timing: .easeOut)
            : nil
    }

    let dataSets: [([Double?], [Double?])] = [
        ([2, 4, 6, 8, 10, 12, 14, 16],
         [7, 3, 5, 5, 11, 13, 14, 10]),

        ([ 8, 1, 16, 15, 13, 13,  9, 10],
         [14, 2, 10,  6, 19,  7, 13,  9])
    ]

    var dataSetIndex: Int = 0

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let vLabels: [String]   = ["A", "B", "C", "D", "E", "F", "G", "H"]
        let hLabels: [String]   = ["2", "4", "6", "8", "10", "12", "14", "16", "18", "20"]

        graffeineView.layer(id: LayerID.bars1)?
            .setData( GraffeineData(valueMax: 20, values: dataSets[dataSetIndex].0),
                      animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.bars2)?
            .setData( GraffeineData(valueMax: 20, values: dataSets[dataSetIndex].1),
                      animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.leftGutter)?
            .data = GraffeineData(labels: vLabels)

        graffeineView.layer(id: LayerID.bottomGutter)?
            .data = GraffeineData(labels: hLabels)
    }
}
