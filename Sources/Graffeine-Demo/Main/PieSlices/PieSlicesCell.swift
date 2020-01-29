import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelection()
    }

    func setupSelection() {
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            if self.selectedIndex != nil {
                self.applySelectionAnimated()
            } else {
                self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
                self.applyDataAnimated()
            }
        }
    }

    let dataSets: [[Double]] = [
        [10, 8, 4, 22, 16, 14],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [1, 1, 2, 3, 5, 8, 13, 21, 34]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    func getData() -> GraffeineData {
        let dataSet = dataSets[dataSetIndex]
        let labels: [String?] = dataSet.map { String(Int($0)) }
        return GraffeineData(valueMax: 100,
                             values: dataSets[dataSetIndex],
                             labels: labels,
                             selectedIndex: selectedIndex)
    }

    func getRandomPieAnimator() -> GraffeinePieDataAnimating {
        switch (Int.random(in: 0...3)) {
        case 3:  return GraffeineAnimation.Data.Pie.Spin(duration: 1.2, timing: .easeInEaseOut)
        default: return GraffeineAnimation.Data.Pie.Automatic(duration: 1.2, timing: .easeInEaseOut)
        }
    }

    func getLabelAnimator() -> GraffeinePieLabelDataAnimating {
        return GraffeineAnimation.Data.PieLabel.FadeIn(duration: 1.2,
                                                       timing: .easeInEaseOut,
                                                       delayRatio: 0.94)
    }

    func applyData() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?.data = newData
        graffeineView.layer(id: LayerID.pieLabels)?.data = newData
    }

    func applyDataAnimated() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?
            .setData(newData, animator: getRandomPieAnimator())

        graffeineView.layer(id: LayerID.pieLabels)?
            .setData(newData, animator: getLabelAnimator())
    }

    func applySelectionAnimated() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?.setData(
            newData,
            animator: GraffeineAnimation.Data.Pie.Morph(duration: 0.22,
                                                       timing: .linear))

        graffeineView.layer(id: LayerID.pieLabels)?.setData(
            newData,
            animator: GraffeineAnimation.Data.PieLabel.Move(duration: 0.22,
                                                           timing: .linear,
                                                           delayRatio: 0))
    }
}
