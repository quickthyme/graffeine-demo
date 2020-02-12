import SwiftUI
import Graffeine

struct ContentView: View {

    @State var dataInput: [GraffeineView.LayerData] = []

    var body: some View {
        VStack {
            Spacer(minLength: 22)

            GraffeineViewRep(configClass: "VerticalDescendingBarsConfig",
                             layerDataInput: $dataInput,
                             onSelect:({
                                guard let result = $0 else { return }
                                self.dataInput = VerticalDescendingBarsDataHelper.makeDataInput(
                                    data: result.data,
                                    semantic: .select)
                             }))

            Button(
                action:({
                    self.dataInput = VerticalDescendingBarsDataHelper.makeDataInput(
                        data: VerticalDescendingBarsDataHelper.generateRandomData(),
                        semantic: .reload)
                }),
                label:({ Text("Reload") })
            )

            Spacer(minLength: 22)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static var previews: some View {
        return ContentView()
    }
}
