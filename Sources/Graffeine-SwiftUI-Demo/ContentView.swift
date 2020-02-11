import SwiftUI
import Graffeine

struct ContentView: View {

    var barData: GraffeineData
    var apply: (GraffeineView) -> ()

    var body: some View {
        VStack {
            GraffeineViewRep(configClass: "VerticalDescendingBarsConfig", apply: apply)
        }
        .navigationBarTitle("Vertical Descending Bars")
    }
}

struct ContentView_Previews: PreviewProvider {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static var previews: some View {
        let values: [Double?] = [8, 7, 6, nil, 4, 3, 2,  1]
        let data = GraffeineData(valuesHi: values,
                                 labels: values.map { ($0 == nil) ? "?" : "\(Int($0!))" })

        return ContentView(barData: data, apply: {
            $0.layer(id: LayerID.bottomGutter)!.data = data
            $0.layer(id: LayerID.bar)!.data = data
            $0.layer(id: LayerID.barLabel)!.data = data
        })
    }
}
