import UIKit
import Graffeine

class ScatterplotCell: UITableViewCell, DemoCell {

    typealias LayerID = ScatterplotConfig.ID
    typealias DataSet = (s: [(x: Double, y: Double)],
        m: [(x: Double, y: Double)],
        l: [(x: Double, y: Double)])

    @IBOutlet weak var graffeineView: GraffeineView!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.currentDataSet = nil
        self.currentColors = nil
        self.currentLabels = nil
        self.applyData(animated: true)
    }

    var currentDataSet: DataSet? = nil
    var currentColors: [[UIColor]]? = nil
    var currentLabels: [[String]]? = nil

    var selectedLayer: LayerID? = nil
    var selectedIndex: Int? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "diagonal_lines")!)
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
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
        UIColor.red.modifiedByAdding(alpha: -0.5),
        UIColor.green.modifiedByAdding(alpha: -0.5),
        UIColor.blue.modifiedByAdding(alpha: -0.5)
    ]

    func generateColors(count: Int) -> [UIColor] {
        return (0..<count).map { _ in
            return UIColor(red:   CGFloat.random(in: 0.1...0.9),
                           green: CGFloat.random(in: 0.1...0.9),
                           blue:  CGFloat.random(in: 0.1...0.9),
                           alpha: 0.5)
        }
    }

    func generateLabels(count: Int, start: Int) -> [String] {
        return (0..<count).enumerated().map {
            return String( self.alphabetLetter(for: $0.offset + start) )
        }
    }

    func alphabetLetter(for intVal: Int) -> Character {
        let A = Int(("A" as UnicodeScalar).value)
        return Character(UnicodeScalar(intVal + A)!)
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
                s: generateData(count: Int.random(in: 1...5)),
                m: generateData(count: Int.random(in: 0...5)),
                l: generateData(count: Int.random(in: 0...5)))
        self.currentDataSet = dataSet

        let colors: [[UIColor]] = currentColors
            ?? [generateColors(count: dataSet.s.count),
                generateColors(count: dataSet.m.count),
                generateColors(count: dataSet.l.count)]
        self.currentColors = colors

        let labels: [[String]] = currentLabels
            ?? [generateLabels(count: dataSet.s.count, start: 0),
                generateLabels(count: dataSet.m.count, start: dataSet.s.count),
                generateLabels(count: dataSet.l.count, start: dataSet.s.count + dataSet.m.count)]
        self.currentLabels = labels

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

        graffeineView.layer(id: LayerID.labels1)?.apply({
            $0.data = GraffeineData(coordinates: dataSet.s,
                                    labels: labels[0],
                                    selectedIndex: (selectedLayer == .vectorPlots1) ? selectedIndex : nil
            )
        })

        graffeineView.layer(id: LayerID.labels2)?.apply({
            $0.data = GraffeineData(coordinates: dataSet.m,
                                    labels: labels[1],
                                    selectedIndex: (selectedLayer == .vectorPlots2) ? selectedIndex : nil
            )
        })

        graffeineView.layer(id: LayerID.labels3)?.apply({
            $0.data = GraffeineData(coordinates: dataSet.l,
                                    labels: labels[2],
                                    selectedIndex: (selectedLayer == .vectorPlots3) ? selectedIndex : nil
            )
        })
    }
}
