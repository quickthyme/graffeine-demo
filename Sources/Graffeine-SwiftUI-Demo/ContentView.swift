import SwiftUI
import Graffeine

struct ContentView: View {

    @State var dataInput: [GraffeineView.LayerData] = []

    var body: some View {
        NavigationView {
            List(0..<1) { item in
                VStack(alignment: .center, spacing: 16) {

                    GraffeineViewRep(configClass: "VerticalDescendingBarsConfig",
                                     layerDataInput: self.$dataInput,
                                     onSelect: ({ graffeineView, selectionResult in
                                        graffeineView.select(index: selectionResult?.data.selected.index,
                                                             semantic: .select)
                                     })).frame(width: nil, height: nil, alignment: .trailing)

                    Button(
                        action:({
                            self.dataInput = VerticalDescendingBarsDataHelper.makeDataInput(
                                data: VerticalDescendingBarsDataHelper.generateRandomData(),
                                semantic: .reload)
                        }),
                        label:({ Text("Reload").foregroundColor(Color(.link)) })
                    ).frame(width: nil, height: 44, alignment: .center)

                }
                .frame(width: nil, height: 320, alignment: .leading)
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(Text("SwiftUI Demo"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    static var previews: some View {
        return ContentView()
    }
}
#endif
