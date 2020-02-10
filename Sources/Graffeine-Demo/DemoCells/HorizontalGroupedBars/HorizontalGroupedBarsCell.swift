import UIKit
import Graffeine

class HorizontalGroupedBarsCell: UITableViewCell, DemoCell {

    typealias LayerID = HorizontalGroupedBarsConfig.ID
    typealias AnimationKey = HorizontalGroupedBarsConfig.AnimationKey

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    let dataSets: [([Double?], [Double?])] = [
        ([2, 4, 6, 8, 10, 12],
         [7, 3, 5, 5, 11, 13]),

        ([ 8, 14, 16,  9, 16, 13],
         [11, 11, 13, 10, 19, 10])
    ]

    var dataSetIndex: Int = 0

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let vLabels: [String]   = ["A", "B", "C", "D", "E", "F"]
        let hLabels: [String]   = ["2", "4", "6", "8", "10", "12", "14", "16", "18", "20"]

        let data1 = GraffeineData(valueMax: 20,
                                  valuesHi: dataSets[dataSetIndex].0,
                                  labels: dataSets[dataSetIndex].0.map {"\(Int($0 ?? 0))"})

        let data2 = GraffeineData(valueMax: 20,
                                  valuesHi: dataSets[dataSetIndex].1,
                                  labels: dataSets[dataSetIndex].1.map {"\(Int($0 ?? 0))"})

        let animationKeys = (animated)
            ? (bar: AnimationKey.bar, label: AnimationKey.label)
            : nil

        graffeineView.layer(id: LayerID.leftGutter)?
            .data = GraffeineData(labels: vLabels)

        graffeineView.layer(id: LayerID.bottomGutter)?
            .data = GraffeineData(labels: hLabels)

        graffeineView.layer(id: LayerID.bars1)?
            .setData(data1, animationKey: animationKeys?.bar)

        graffeineView.layer(id: LayerID.bars2)?
            .setData(data2, animationKey: animationKeys?.bar)

        graffeineView.layer(id: LayerID.barLabel1)?
            .setData(data1, animationKey: animationKeys?.label)

        graffeineView.layer(id: LayerID.barLabel2)?
            .setData(data2, animationKey: animationKeys?.label)
    }
}
