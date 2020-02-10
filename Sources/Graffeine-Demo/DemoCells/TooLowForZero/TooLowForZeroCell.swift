import UIKit
import Graffeine

class TooLowForZeroCell: UITableViewCell, DemoCell {

    typealias LayerID = TooLowForZeroConfig.ID
    typealias AnimationKey = TooLowForZeroConfig.AnimationKey

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
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
            self.applyData(animated: true)
        }
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Bar.Grow(duration: 0.88, timing: .easeInEaseOut)
            : nil
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

        let colors: [UIColor] = currentValues.map { ($0 ?? 0 < 0)
            ? .systemRed
            : .systemBlue
        }

        let labelColors: [UIColor] = currentValues.map {
            let val = $0 ?? 0
            switch true {
            case (val < 0): return .systemRed
            case (val > 0): return .inverseLabel
            default:    return .label
            }
        }

        let data = GraffeineData(valueMax: 10,
                                 valueMin: -10,
                                 valuesHi: currentValues,
                                 labels: labels,
                                 selectedIndex: selectedIndex)

        let animationKeyBar = (animated) ? AnimationKey.bar : nil

        (graffeineView.layer(id: LayerID.bar) as? GraffeineBarLayer)?
            .apply({
                $0.unitFill.colors = colors
                $0.setData(data, animationKey: animationKeyBar)
            })

        (graffeineView.layer(id: LayerID.barLabel) as? GraffeineHorizontalLabelLayer)?
            .apply({
                $0.unitText.colors = labelColors
                $0.data = data
            })
    }
}
