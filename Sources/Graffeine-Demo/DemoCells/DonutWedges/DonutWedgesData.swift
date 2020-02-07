import UIKit
import Graffeine

class DonutWedgesData {

    let dataSets: [[Double]] = [
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [10, 8, 4, 22, 16, 14],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [1, 1, 2, 3, 5, 8, 13, 21]
    ]

    func dataSetIsFibonacci(_ index: Int) -> Bool {
        return (index == 3)
    }

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
        let maxVal: Double = (dataSetIsFibonacci(dataSetIndex))
            ? 89
            : dataSet.reduce(0, +)

        let labels: [String?] = dataSet.enumerated().map {
            return (dataSetIsFibonacci(dataSetIndex))
                ? "\(Int($0.element))"
                : "\(self.alphabetLetter(for: $0.offset))"
        }

        let selectedLabels: [String?] = dataSet.enumerated().map {
            return ((dataSetIsFibonacci(dataSetIndex))
                ? "Fibonacci \($0.offset + 1)\n"
                : "Slice \(self.alphabetLetter(for: $0.offset))\n")
                + "\(Int($0.element)) out of \(Int(maxVal))\n"
        }

        return GraffeineData(valueMax: maxVal,
                             valuesHi: dataSets[dataSetIndex],
                             labels: labels,
                             selectedLabels: selectedLabels,
                             selectedIndex: selectedIndex)
    }
}
