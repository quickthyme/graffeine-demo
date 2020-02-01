import UIKit
import Graffeine

class HorizontalGroupedBarsCell: UITableViewCell, DataAppliable {

    typealias LayerID = HorizontalGroupedBarsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Bar.Grow(duration: 0.8, timing: .easeOut)
            : nil
    }

    func barLabelAnimator(_ animated: Bool) -> GraffeineLabelDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Label.Slide(duration: 0.8, timing: .easeOut)
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

        let data1 = GraffeineData(valueMax: 20,
                                  valuesHi: dataSets[dataSetIndex].0,
                                  labels: dataSets[dataSetIndex].0.map {"\(Int($0 ?? 0))"})

        let data2 = GraffeineData(valueMax: 20,
                                  valuesHi: dataSets[dataSetIndex].1,
                                  labels: dataSets[dataSetIndex].1.map {"\(Int($0 ?? 0))"})

        graffeineView.layer(id: LayerID.leftGutter)?
            .data = GraffeineData(labels: vLabels)

        graffeineView.layer(id: LayerID.bottomGutter)?
            .data = GraffeineData(labels: hLabels)

        graffeineView.layer(id: LayerID.bars1)?
            .setData( data1, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.bars2)?
            .setData( data2, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.barLabel1)?
            .setData( data1, animator: barLabelAnimator(animated) )

        graffeineView.layer(id: LayerID.barLabel2)?
            .setData( data2, animator: barLabelAnimator(animated) )
    }
}
