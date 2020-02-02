import UIKit
import Graffeine

class DetailRingsData {

    let dataSets: [[Double]] = [
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
    ]

    let augmentedDataSets: [[Double]] = [
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
         10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
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

    func get() -> (GraffeineData, GraffeineData) {
        let dataSet = dataSets[dataSetIndex]
        let augDataSet = augmentedDataSets[dataSetIndex]
        let maxVal: Double = 100
        let augMaxVal: Double = 1000

        let labels: [String?] = dataSet.enumerated().map {
            return "\(self.alphabetLetter(for: $0.offset))"
        }

        let augLabels: [String?] = augDataSet.enumerated().map {
            return "\($0.offset)"
        }

        return (
            GraffeineData(valueMax: maxVal,
                          valuesHi: dataSet,
                          labels: labels),
            GraffeineData(valueMax: augMaxVal,
                          valuesHi: augDataSet,
                          labels: augLabels)
        )
    }
}
