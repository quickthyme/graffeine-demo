import UIKit
import Graffeine

class PieSlicesData {

    let dataSets: [[Double]] = [
        [10, 8, 4, 22, 16, 14],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [1, 1, 2, 3, 5, 8, 13, 21]
    ]

    var dataSetIndex: Int = 0

    var selectedIndex: Int? = nil

    func incrementDataSetIndex() {
        self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
    }

    func alphabetLetter(for intVal: Int) -> Character {
        let A = Int(("A" as UnicodeScalar).value) // 65
        return Character(UnicodeScalar(intVal + A)!)
    }

    func get() -> GraffeineData {
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
}
