import UIKit
import Graffeine

class CandlestickCell: UITableViewCell, DataAppliable {

    typealias LayerID = CandlestickConfig.ID
    typealias GutterLayerID = CandlestickGutterConfig.ID

    @IBOutlet weak var leftGutterView: GraffeineView!
    @IBOutlet weak var graffeineView: GraffeineView!

    var selectedIndex: Int? = nil
    var lanes: TradingDayLanes?

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selectedIndex
            self.lanes = (self.selectedIndex == nil) ? nil : self.lanes
            self.applyData(animated: true)
        }
    }

    func labelAnimator(_ animated: Bool) -> GraffeineLabelDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Label.Slide(duration: 0.8, timing: .easeOut)
            : nil
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Bar.Grow(duration: 0.8, timing: .easeOut)
            : nil
    }

    var dataSet: [TradingDay] {
        return TradingDay.generateRandom(numberOfDays: 90, lowest: 10, highest: 90)
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {

        if self.lanes == nil { self.lanes = TradingDayLanes.import(dataSet) }
        let lanes = self.lanes!

        let nf = NumberFormatter()
        nf.numberStyle = .currency

        let maxVal = ceil(lanes.peakHi.max()!)
        let lowestVal = floor(lanes.peakLo.min()!)
        let range = maxVal - lowestVal

        let gutterLabelData = GraffeineData(labels: [
            "\(nf.string(from: NSNumber(value: maxVal))!)",
            " ",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.8)))!)",
            " ",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.6)))!)",
            " ",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.4)))!)",
            " ",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.2)))!)",
            " ",
            "\(nf.string(from: NSNumber(value: lowestVal))!)"
        ])

        let candleData = GraffeineData(valueMax: maxVal - lowestVal,
                                       valuesHi: lanes.hi.map { $0 - lowestVal },
                                       valuesLo: lanes.lo.map { $0 - lowestVal },
                                       labels: lanes.labels,
                                       selectedIndex: selectedIndex)


        let wickData = GraffeineData(valueMax: maxVal - lowestVal,
                                     valuesHi: lanes.peakHi.map { $0 - lowestVal },
                                     valuesLo: lanes.peakLo.map { $0 - lowestVal },
                                     selectedIndex: selectedIndex)

        leftGutterView.layer(id: GutterLayerID.mainGutter)?.data = gutterLabelData

        graffeineView.layer(id: LayerID.wick)?
            .setData( wickData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.candle)?
            .unitFill.colors = lanes.colors

        graffeineView.layer(id: LayerID.candle)?
            .setData( candleData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.candleLabel)?
            .setData( candleData, animator: labelAnimator(animated) )
    }
}
