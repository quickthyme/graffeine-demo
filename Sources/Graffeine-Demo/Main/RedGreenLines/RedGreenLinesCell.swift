import UIKit
import Graffeine

class RedGreenLinesCell: UITableViewCell, DataAppliable {

    typealias LayerID = RedGreenLinesConfig.ID

    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.regenerateData()
        graffeineView.onSelect = { _ in
            self.regenerateData()
            self.applyData(animated: true)
        }
    }

    var greenHistorical: [Double?] = []
    var greenProjected: [Double?] = []
    var redHistorical: [Double?] = []
    var redProjected: [Double?] = []

    func regenerateData() {
        self.greenHistorical = generateRandomValues(6, min: 14, max: 50)
        self.greenProjected = generateNilDoubles(5) + generateProjection(greenHistorical)
        self.redHistorical = generateRandomValues(6, min: 4, max: 40)
        self.redProjected = generateNilDoubles(5) + generateProjection(redHistorical)
    }

    func applyData() {
        applyData(animated: false)
    }

    func lineAnimator(_ animated: Bool) -> GraffeineLineDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Line.Trace(delay: 0, duration: 1.8, timing: .easeIn)
            : nil
    }

    func projectionLineAnimator(_ animated: Bool) -> GraffeineLineDataAnimating? {
        return (animated)
            ? GraffeineAnimation.Data.Line.Trace(delay: 1.8, duration: 0.2, timing: .linear)
            : nil
    }

    func generateNilDoubles(_ count: Int) -> [Double?] {
        return (0..<count).map { _ in return nil }
    }

    func generateRandomValues(_ count: Int, min: Double, max: Double) -> [Double] {
        return (0..<count).map { _ in return normalized(Double.random(in: min...max)) }
    }

    func normalized(_ input: Double) -> Double {
        return ceil(input * 100) / 100
    }

    func generateProjection(_ input: [Double?]) -> [Double?] {
        let inputCount = input.count
        guard
            (inputCount > 1),
            let last = input[inputCount - 1],
            let before = input[inputCount - 2]
            else { return [nil] }
        let proj = last + (last - before)
        return [last, proj]
    }

    func applyData(animated: Bool) {

        graffeineView.layer(id: LayerID.redLineProj)?
            .setData(GraffeineData(valueMax: 50, valuesHi: redProjected),
                     animator: projectionLineAnimator(animated))

        graffeineView.layer(id: LayerID.redLine)?
            .setData(GraffeineData(valueMax: 50, valuesHi: redHistorical + [nil]),
                 animator: lineAnimator(animated))

        graffeineView.layer(id: LayerID.greenLineProj)?
            .setData(GraffeineData(valueMax: 50, valuesHi: greenProjected),
                     animator: projectionLineAnimator(animated))

        graffeineView.layer(id: LayerID.greenLine)?
            .setData(GraffeineData(valueMax: 50, valuesHi: greenHistorical + [nil]),
                 animator: lineAnimator(animated))
    }
}
