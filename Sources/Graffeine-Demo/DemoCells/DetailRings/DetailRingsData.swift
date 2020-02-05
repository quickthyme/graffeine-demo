import UIKit
import Graffeine

class DetailRingsData {

    typealias LayerID = DetailRingsConfig.ID

    let centerDataSets: [[Double]] = [
        [10, 10, 10, 10, 10]
    ]

    let centerLabelSets: [[String]] = [
        ["A", "B", "C", "D", "E"]
    ]

    let ring1DataSets: [[Double]] = [
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    ]

    let ring1LabelSets: [[String]] = [
        ["A1", "A2", "B1", "B2", "C1", "C2", "D1", "D2", "E1", "E2"]
    ]

    let ring2DataSets: [[Double]] = [
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
        self.dataSetIndex = (self.dataSetIndex + 1) % self.centerDataSets.count
    }

    func get(selectedIndex: Int?, selectedLayerIndex: Int?) -> (GraffeineData, GraffeineData, GraffeineData) {
        let centerData = centerDataSets[dataSetIndex]
        let ring1Data = ring1DataSets[dataSetIndex]
        let ring2Data = ring2DataSets[dataSetIndex]

        let centerLabels = centerLabelSets[dataSetIndex]
        let ring1Labels  = ring1LabelSets[dataSetIndex]

        let ring2Labels: [String?] = ring2Data.enumerated()
            .map { "\($0.offset + 1)" }

        let selectedIndex0 = (selectedLayerIndex == 0) ? selectedIndex : nil
        let selectedIndex1 = (selectedLayerIndex == 1) ? selectedIndex : nil
        let selectedIndex2 = (selectedLayerIndex == 2) ? selectedIndex : nil

        return (
            GraffeineData(valuesHi: centerData,
                          labels: centerLabels,
                          selectedIndex: selectedIndex0),
            GraffeineData(valuesHi: ring1Data,
                          labels: ring1Labels,
                          selectedIndex: selectedIndex1),
            GraffeineData(valuesHi: ring2Data,
                          labels: ring2Labels,
                          selectedIndex: selectedIndex2)
        )
    }
}
