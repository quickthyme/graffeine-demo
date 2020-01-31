import UIKit
import Graffeine

class ScatterplotCell: UITableViewCell, DataAppliable {

    typealias LayerID = ScatterplotConfig.ID
    typealias DataSet = (s: [(x: Double, y: Double)],
        m: [(x: Double, y: Double)],
        l: [(x: Double, y: Double)])

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.currentDataSet = nil
        self.currentColors = nil
        self.applyData(animated: true)
    }

    var currentDataSet: DataSet? = nil
    var currentColors: [[UIColor]]? = nil

    var selectedLayer: LayerID? = nil
    var selectedIndex: Int? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            self.selectedLayer = selection?.layer.id as? LayerID
            self.applyData(animated: true)
        }
    }

    func generateData(count: Int) -> [(x: Double, y: Double)] {
        return (0..<count).map { _ in
            return (normalized(Double.random(in: 1...20)),
                    normalized(Double.random(in: 1...20)))
        }
    }

    private let pallette: [UIColor] = [
        UIColor.systemRed.modifiedByAdding(alpha: -0.5),
        UIColor.systemGreen.modifiedByAdding(alpha: -0.5),
        UIColor.systemIndigo.modifiedByAdding(alpha: -0.5)
    ]

    func generateColors(count: Int) -> [UIColor] {
        return (0..<count).map { _ in
            let index = Int.random(in: 0..<pallette.count)
            return pallette[index]
        }
    }

    func normalized(_ val: Double) -> Double {
        return floor(val * 100) / 100
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {
        let dataSet = self.currentDataSet
            ?? DataSet(
                s: generateData(count: Int.random(in: 0...7)),
                m: generateData(count: Int.random(in: 0...7)),
                l: generateData(count: Int.random(in: 0...7)))
        self.currentDataSet = dataSet

        let colors: [[UIColor]] = currentColors
            ?? [generateColors(count: dataSet.s.count),
                generateColors(count: dataSet.m.count),
                generateColors(count: dataSet.l.count)]
        self.currentColors = colors

        graffeineView.layer(id: LayerID.vectorPlots1)?.apply({
            $0.unitFill.colors = colors[0]
            $0.data = GraffeineData(
                coordinates: dataSet.s,
                labels: [],
                selectedLabels: [],
                selectedIndex: (selectedLayer == .vectorPlots1) ? selectedIndex : nil
            )
        })

        graffeineView.layer(id: LayerID.vectorPlots2)?.apply({
            $0.unitFill.colors = colors[1]
            $0.data = GraffeineData(
                coordinates: dataSet.m,
                labels: [],
                selectedLabels: [],
                selectedIndex: (selectedLayer == .vectorPlots2) ? selectedIndex : nil
            )
        })

        graffeineView.layer(id: LayerID.vectorPlots3)?.apply({
            $0.unitFill.colors = colors[2]
            $0.data = GraffeineData(
                coordinates: dataSet.l,
                labels: [],
                selectedLabels: [],
                selectedIndex: (selectedLayer == .vectorPlots3) ? selectedIndex : nil
            )
        })
    }
}
