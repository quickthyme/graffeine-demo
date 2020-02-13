import UIKit
import Graffeine

class RadarZoneCell: UITableViewCell, DemoCell {

    typealias LayerID = RadarZoneConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        generateNewValues()
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.backgroundColor = .diagonalLines
    }

    var currentValues: ([Double], [Double]) = ([], [])

    func generateNewValues() {
        currentValues = (
            generateRandomSeries(5,  0,  10),
            generateRandomSeries(5,  0,  10)
        )
    }

    func generateRandomSeries(_ count: Int, _ lo: Double, _ hi: Double) -> [Double] {
        return (0..<count).map { _ in return ceil(Double.random(in: lo...hi) * 10) / 10 }
    }

    var radarData: (GraffeineData, GraffeineData) {
        let maxValue = Double(10)
        let values = currentValues
        return (
            GraffeineData(valueMax: maxValue, valuesHi: values.0),
            GraffeineData(valueMax: maxValue, valuesHi: values.1)
        )
    }

    func applyData() {
        self.applyData(animated: true)
    }

    func applyData(animated: Bool) {
        if currentValues.0.isEmpty { generateNewValues() }
        let data = radarData
        let semantic: GraffeineData.AnimationSemantic = (animated) ? .reload : .notAnimated
        graffeineView.layer(id: LayerID.zone1)?.setData(data.0, semantic: semantic)
        graffeineView.layer(id: LayerID.zone2)?.setData(data.1, semantic: semantic)
    }
}
