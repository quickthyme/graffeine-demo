import UIKit
import SwiftUI
import Graffeine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let values: [Double?] = [8, 7, 6, nil, 4, 3, 2,  1]
        let data = GraffeineData(valuesHi: values,
                                 labels: values.map { ($0 == nil) ? "?" : "\(Int($0!))" })

        let contentView = ContentView(barData: data, apply: {
            $0.layer(id: LayerID.bottomGutter)!.data = data
            $0.layer(id: LayerID.bar)!.data = data
            $0.layer(id: LayerID.barLabel)!.data = data
        })

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
