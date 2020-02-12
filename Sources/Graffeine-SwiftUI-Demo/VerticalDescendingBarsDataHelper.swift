import SwiftUI
import Graffeine

struct VerticalDescendingBarsDataHelper {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static func makeDataInput(data: GraffeineData, semantic: GraffeineData.AnimationSemantic) -> [GraffeineView.LayerData] {
        return [
            (layerId: LayerID.bottomGutter, data: data, semantic: semantic),
            (layerId: LayerID.bar, data: data, semantic: semantic),
            (layerId: LayerID.barLabel, data: data, semantic: semantic)
        ]
    }

    static func generateInitialData() -> GraffeineData {
        let values: [Double?] = [8, 7, 6, nil, 4, 3, 2,  1]
        return GraffeineData(valueMax: 10, valuesHi: values, labels: mapLabels(values))
    }

    static func generateRandomData() -> GraffeineData {
        let values: [Double?] = (0...7).map { _ in return Double( Int.random(in: 0...10) ) }
        return GraffeineData(valueMax: 10, valuesHi: values, labels: mapLabels(values))
    }

    static func mapLabels(_ values: [Double?]) -> [String] {
        return values.map { ($0 == nil) ? "?" : "\(Int($0!))" }
    }
}
