import UIKit
import Graffeine

class LinePointsCell: UITableViewCell, DataAppliable {

    typealias LayerID = LinePointsConfig.ID
    
    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            if self.selectedIndex == nil {
                self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
            }
            self.applyDataAnimated()
        }
    }

    let dataSets: [[Double]] = [
        [1, 1, 2, 3, 5, 8, 13, 21, 34],
        [2, 0, 3, 1, 4, 2, 5, 3, 6, 4, 7, 5, 8, 6, 9, 7, 10],
        [5, 3, 4, 2, 1, 2, 6]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    var lineAndPointData: GraffeineData {
        let values = dataSets[dataSetIndex]
        return GraffeineData(valueMax: values.max()!,
                             values: values + [nil],
                             labels: values.map { String(Int($0)) },
                             selectedIndex: selectedIndex)
    }

    func applyData() {
        graffeineView.layer(id: LayerID.line)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.point)?.data = lineAndPointData
        graffeineView.layer(id: LayerID.pointLabel)?.data = lineAndPointData
    }

    func applyDataAnimated() {
        graffeineView.layer(id: LayerID.line)!.setData(lineAndPointData, animator:
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

        graffeineView.layer(id: LayerID.point)!
            .setData(lineAndPointData, animator: pointAnimator)

        graffeineView.layer(id: LayerID.pointLabel)!
            .setData(lineAndPointData, animator: labelAnimator)
    }
}
