import SwiftUI
import Graffeine

struct ContentView: View {

    @State var dataInput: [GraffeineView.LayerData] = []

    var body: some View {
        VStack {
            Spacer(minLength: 22)

            GraffeineViewRep(configClass: "VerticalDescendingBarsConfig",
                             layerDataInput: $dataInput,
                             onSelect: onBarSelect)

            Button(
                action: {
                    self.dataInput = ContentViewGraffeineDataHelper.makeDataInput(
                        data: ContentViewGraffeineDataHelper.generateRandomData(),
                        semantic: .reload
                    )},
                label: { Text("Reload") }
            )

            Spacer(minLength: 22)
        }
    }

    func onBarSelect(_ result: GraffeineLayer.SelectionResult?) {
        if let result = result {
            self.dataInput = ContentViewGraffeineDataHelper.makeDataInput(data: result.data,
                                                                          semantic: .select)
        }
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

    static func makeDataInput(data: GraffeineData, semantic: GraffeineData.AnimationSemantic) -> [GraffeineView.LayerData] {
        return [
            (layerId: LayerID.bottomGutter, data: data, semantic: semantic),
            (layerId: LayerID.bar, data: data, semantic: semantic),
            (layerId: LayerID.barLabel, data: data, semantic: semantic)
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
