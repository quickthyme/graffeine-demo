import UIKit
import Graffeine

class DetailRingsData {

    typealias LayerID = DetailRingsConfig.ID

    let innerDataSets: [[Double]] = [
        [10, 10, 10, 10, 10]
    ]

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

    func get(selectedIndex: Int?, selectedLayerIndex: Int?) -> (GraffeineData, GraffeineData, GraffeineData) {
        let innerDataSet = innerDataSets[dataSetIndex]
        let dataSet = dataSets[dataSetIndex]
        let augDataSet = augmentedDataSets[dataSetIndex]

        let labels: [String?] = dataSet.enumerated().map {
            return "\(self.alphabetLetter(for: $0.offset))"
        }

        let augLabels: [String?] = augDataSet.enumerated().map {
            return "\($0.offset)"
        }

        let selectedIndex0 = (selectedLayerIndex == 0) ? selectedIndex : nil
        let selectedIndex1 = (selectedLayerIndex == 1) ? selectedIndex : nil
        let selectedIndex2 = (selectedLayerIndex == 2) ? selectedIndex : nil

        return (
            GraffeineData(valuesHi: innerDataSet,
                          selectedIndex: selectedIndex0),
            GraffeineData(valuesHi: dataSet,
                          labels: labels,
                          selectedIndex: selectedIndex1),
            GraffeineData(valuesHi: augDataSet,
                          labels: augLabels,
                          selectedIndex: selectedIndex2)
        )
    }
}
