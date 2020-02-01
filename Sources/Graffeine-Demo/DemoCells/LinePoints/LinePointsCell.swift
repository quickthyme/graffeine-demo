import UIKit
import Graffeine

class LinePointsCell: UITableViewCell, DemoCell {

    typealias LayerID = LinePointsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.selectedIndex = nil
        self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
        self.applyDataAnimated()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
            self.applySelection()
        }
    }

    let dataSets: [[Double]] = [
        [5, 3, 4, 2, 1, 2, 6],
        [34, 21, 13, 8, 5, 3, 2, 1, 1],
        [2, 2, 3, 4.5, 4, 4.5, 3, 2, 2],
        [3, 1, 4, 2, 5, 3, 6, 4, 7, 5, 8, 6]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    var lineAndPointData: GraffeineData {
        let values = dataSets[dataSetIndex]
        return GraffeineData(valueMax: max(values.max()!, 8),
                             valuesHi: values,
                             labels: values.map { String(Int($0)) },
                             selectedIndex: selectedIndex)
    }

    func applyData() {
        graffeineView.layer(id: LayerID.line)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.point)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.pointLabel)?.data = lineAndPointData
    }

    func applyDataAnimated() {
        graffeineView.layer(id: LayerID.line)?.setData(lineAndPointData, animator:
            GraffeineAnimation.Data.Line.Morph(duration: 2.0,
                                               timing: .easeInEaseOut))

        let pointAnimator = (selectedIndex == nil)
                ? GraffeineAnimation.Data.Plot.FadeIn(duration: 2.0,
                                                      timing: .easeInEaseOut,
                                                      delayRatio: 0.99)
                : nil

        let labelAnimator = (selectedIndex == nil)
                ? GraffeineAnimation.Data.PlotLabel.FadeIn(duration: 2.0,
                                                           timing: .easeInEaseOut,
                                                           delayRatio: 0.99)
                : nil

        graffeineView.layer(id: LayerID.point)?
            .setData(lineAndPointData, animator: pointAnimator)

        graffeineView.layer(id: LayerID.pointLabel)?
            .setData(lineAndPointData, animator: labelAnimator)
    }

    func applySelection() {
        graffeineView.layer(id: LayerID.point)?
            .setData(lineAndPointData, animator: nil)

        graffeineView.layer(id: LayerID.pointLabel)?
            .setData(lineAndPointData, animator: nil)
    }
}
