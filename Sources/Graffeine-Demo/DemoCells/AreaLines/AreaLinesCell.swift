import UIKit
import Graffeine

class AreaLinesCell: UITableViewCell, DemoCell {

    typealias LayerID = AreaLinesConfig.ID
    typealias AnimationKey = AreaLinesConfig.AnimationKey

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        generateNewDataSet()
        self.applyDataAnimated()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.backgroundColor = .diagonalLines
        graffeineView.onSelect = { selection in
            self.selectedLayerID = selection?.layer.id as? LayerID
            self.applyDataAnimated()
        }
    }

    func generateRandomSeries(_ count: Int, _ lo: Double, _ hi: Double) -> [Double] {
        return (0..<count).map { _ in return floor(Double.random(in: lo...hi) * 100) / 100 }
    }

    var currentDataSet: ([Double], [Double], [Double]) = ([], [], [])

    var selectedLayerID: LayerID?

    func generateNewDataSet() {
        currentDataSet = (
            generateRandomSeries(150,  85, 100),
            generateRandomSeries( 75,  50,  75),
            generateRandomSeries( 25,  20,  35)
        )
    }

    var lineData: (GraffeineData, GraffeineData, GraffeineData) {
        let dataSet = currentDataSet
        let maxValue = Double(130)
        return (
            GraffeineData(valueMax: maxValue,
                          valuesHi: dataSet.0,
                          valuesLo: dataSet.1,
                          selectedIndex: getSelectedIndex(LayerID.line1)),
            GraffeineData(valueMax: maxValue,
                          valuesHi: dataSet.1,
                          valuesLo: dataSet.2,
                          selectedIndex: getSelectedIndex(LayerID.line2)),
            GraffeineData(valueMax: maxValue,
                          valuesHi: dataSet.2,
                          selectedIndex: getSelectedIndex(LayerID.line3))
        )
    }

    func getSelectedIndex(_ forLayerID: LayerID?) -> Int? {
        guard let forLayerID = forLayerID,
            (forLayerID == self.selectedLayerID)
            else { return nil }
        return 0
    }

    func applyData() {
        if currentDataSet.0.isEmpty { generateNewDataSet() }
        let lineData = self.lineData
        graffeineView.layer(id: LayerID.line1)?.data = lineData.0
        graffeineView.layer(id: LayerID.line2)?.data = lineData.1
        graffeineView.layer(id: LayerID.line3)?.data = lineData.2
    }

    func applyDataAnimated() {
        let lineData = self.lineData

        graffeineView.layer(id: LayerID.line1)?
            .setData(lineData.0, animationKey: AnimationKey.lineMorph)

        graffeineView.layer(id: LayerID.line2)?
            .setData(lineData.1, animationKey: AnimationKey.lineMorph)

        graffeineView.layer(id: LayerID.line3)?
            .setData(lineData.2, animationKey: AnimationKey.lineMorph)
    }
}
