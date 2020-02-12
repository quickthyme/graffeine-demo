import SwiftUI
import Graffeine

struct ContentView: View {

    @State var dataInput: [GraffeineView.LayerData] = []

    var body: some View {
        VStack {
            GraffeineViewRep(configClass: "VerticalDescendingBarsConfig",
                             layerDataInput: $dataInput)
            Button(
                action: {
                    self.dataInput = ContentViewGraffeineDataHelper.prepareForGraffeine(
                        ContentViewGraffeineDataHelper.generateRandomData()
                    )},
                label: { Text("Reload") }
            )
        }
        .navigationBarTitle("Vertical Descending Bars")
    }
}

struct ContentView_Previews: PreviewProvider {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static var previews: some View {
        return ContentView()
    }
}

struct ContentViewGraffeineDataHelper {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static func prepareForGraffeine(_ data: GraffeineData) -> [GraffeineView.LayerData] {
        return [
            (layerId: LayerID.bottomGutter, data: data, semantic: .reload),
            (layerId: LayerID.bar, data: data, semantic: .reload),
            (layerId: LayerID.barLabel, data: data, semantic: .reload)
        ]
    }

    static func generateInitialData() -> GraffeineData {
        let values: [Double?] = [8, 7, 6, nil, 4, 3, 2,  1]
        return GraffeineData(valuesHi: values, labels: mapLabels(values))
    }

    static func generateRandomData() -> GraffeineData {
        let values: [Double?] = (0...7).map { _ in return Double( Int.random(in: 0...10) ) }
        return GraffeineData(valuesHi: values, labels: mapLabels(values))
    }

    static func mapLabels(_ values: [Double?]) -> [String] {
        return values.map { ($0 == nil) ? "?" : "\(Int($0!))" }
    }
}
