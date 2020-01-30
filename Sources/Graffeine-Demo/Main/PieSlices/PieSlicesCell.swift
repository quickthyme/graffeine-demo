import UIKit
import Graffeine

class PieSlicesCell: UITableViewCell, DataAppliable {

    typealias LayerID = PieSlicesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.backgroundColor = UIColor(patternImage: UIImage(named: "diagonal_lines")!)
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
        [1, 1, 2, 3, 5, 8, 13, 21]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    func alphabetLetter(for intVal: Int) -> Character {
        let A = Int(("A" as UnicodeScalar).value) // 65
        return Character(UnicodeScalar(intVal + A)!)
    }

    func getData() -> GraffeineData {
        let dataSet = dataSets[dataSetIndex]
        let maxVal: Double = (dataSetIndex < 2)
            ? dataSet.reduce(0, +)
            : 89

        let labels: [String?] = dataSet.enumerated().map {
            return (dataSetIndex < 2)
                ? "\(self.alphabetLetter(for: $0.offset))"
                : "\(Int($0.element))"
        }

        let selectedLabels: [String?] = dataSet.enumerated().map {
            return ((dataSetIndex < 2)
                ? "Slice \(self.alphabetLetter(for: $0.offset))\n"
                : "Fibonacci \($0.offset + 1)\n")
                + "\(Int($0.element)) out of \(Int(maxVal))\n"
        }

        return GraffeineData(valueMax: maxVal,
                             values: dataSets[dataSetIndex],
                             labels: labels,
                             selectedLabels: selectedLabels,
                             selectedIndex: selectedIndex)
    }

    func getRandomPieAnimator() -> GraffeineRadialSegmentDataAnimating {
        switch (Int.random(in: 0...3)) {
        case 3:  return GraffeineAnimation.Data.RadialSegment.Spin(duration: 1.2, timing: .easeInEaseOut)
        default: return GraffeineAnimation.Data.RadialSegment.Automatic(duration: 1.2, timing: .easeInEaseOut)
        }
    }

    func getLabelAnimator() -> GraffeineRadialLabelDataAnimating {
        return GraffeineAnimation.Data.RadialLabel.FadeIn(duration: 1.2,
                                                          timing: .easeInEaseOut,
                                                          delayRatio: 0.94)
    }

    func getLineAnimator() -> GraffeineRadialLineDataAnimating {
        return GraffeineAnimation.Data.RadialLine.FadeIn(duration: 1.2,
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

        graffeineView.layer(id: LayerID.pieLabelLines)?
            .setData(newData, animator: getLineAnimator())
    }

    func applySelectionAnimated() {
        let newData = getData()
        graffeineView.layer(id: LayerID.pie)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialSegment.Morph(duration: 0.22,
                                                                  timing: .linear))

        graffeineView.layer(id: LayerID.pieLabels)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialLabel.Move(duration: 0.22,
                                                               timing: .linear,
                                                               delayRatio: 0))

        graffeineView.layer(id: LayerID.pieLabelLines)?.setData(
            newData,
            animator: GraffeineAnimation.Data.RadialLine.FadeIn(duration: 0.33,
                                                                timing: .linear,
                                                                delayRatio: 0))
    }
}
