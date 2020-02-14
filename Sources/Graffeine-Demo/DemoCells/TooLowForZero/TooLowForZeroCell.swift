import UIKit
import Graffeine

class TooLowForZeroCell: UITableViewCell, DemoCell {

    typealias LayerID = TooLowForZeroConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.currentValues = []
        self.applyData(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelection()
    }

    func setupSelection() {
        graffeineView.onSelect = { _, selection in
            self.selectedIndex = selection?.data.selected.index
            self.applyData(animated: true)
        }
    }

    var currentValues: [Double?] = []

    func generateNewValues(_ count: Int) -> [Double?] {
        return (0..<count).map { _ in return Double(Int.random(in: -10...10)) }
    }

    var selectedIndex: Int? = nil

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        if currentValues.isEmpty { currentValues = generateNewValues(24) }
        let labels: [String] = currentValues.map { ($0 == nil) ? "" : "\(Int($0!))" }
        let data = GraffeineData(valueMax: 10,
                                 valueMin: -10,
                                 valuesHi: currentValues,
                                 labels: labels,
                                 selectedIndex: selectedIndex)

        let semantic: GraffeineData.AnimationSemantic = (animated) ? .reload : .notAnimated

        graffeineView.layerDataInput = [
            (layerId: LayerID.bar, data: data, semantic: semantic),
            (layerId: LayerID.barLabel, data: data, semantic: semantic)
        ]
    }
}
