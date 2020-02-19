import UIKit
import Graffeine

class TriforceCell: UITableViewCell, DemoCell {

    typealias LayerID = TriforceConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        generateNewValues()
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var currentValues: [Double] = []

    func generateNewValues() {
        currentValues = generateRandomSeries(count: 3, lo: 0, hi: 9)
    }

    func generateRandomSeries(count: Int, lo: Double, hi: Double) -> [Double] {
        return (0..<count).map { _ in return ceil(Double.random(in: lo...hi) * 10) / 10 }
    }

    var triforceData: GraffeineData {
        let maxValue = Double(9)
        let values = currentValues
        return GraffeineData(valueMax: maxValue, valuesHi: values)
    }

    func applyData() {
        self.applyData(animated: false)
    }

    func applyData(animated: Bool) {
        if currentValues.isEmpty { generateNewValues() }
        let data = triforceData
        let semantic: GraffeineData.AnimationSemantic = (animated) ? .reload : .notAnimated
        graffeineView.layerDataInput = [
            (layerId: LayerID.triforce, data: data, semantic: semantic)
        ]
    }
}
