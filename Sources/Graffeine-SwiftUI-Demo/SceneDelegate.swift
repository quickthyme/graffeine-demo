import UIKit
import SwiftUI
import Graffeine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    typealias LayerID = VerticalDescendingBarsConfig.ID

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let dataInput = VerticalDescendingBarsDataHelper.makeDataInput(
            data: VerticalDescendingBarsDataHelper.generateInitialData(),
            semantic: .notAnimated
        )
        let contentView = ContentView(dataInput: dataInput)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }


}
