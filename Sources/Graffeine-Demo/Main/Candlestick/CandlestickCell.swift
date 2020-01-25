import UIKit
import Graffeine

class CandlestickCell: UITableViewCell, DataAppliable {

    typealias LayerID = CandlestickConfig.ID

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

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Bar.Grow(duration: 0.8, timing: .easeOut)
            : nil
    }

    var dataSet: [TradingDay] {
        return TradingDay.generateRandom(numberOfDays: 15, lowest:  32, highest:  64)
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
        let vLabels = [
            "\(nf.string(from: NSNumber(value: maxVal))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.9)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.8)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.7)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.6)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.5)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.4)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.3)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.2)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal + (range * 0.1)))!)",
            "\(nf.string(from: NSNumber(value: lowestVal))!)"
        ]

        let candleData = GraffeineData(valueMax: maxVal - lowestVal,
                                       valuesHi: lanes.hi.map { $0 - lowestVal },
                                       valuesLo: lanes.lo.map { $0 - lowestVal },
                                       labels: vLabels,
                                       selectedIndex: selectedIndex)

        let wickData = GraffeineData(valueMax: maxVal - lowestVal,
                                     valuesHi: lanes.peakHi.map { $0 - lowestVal },
                                     valuesLo: lanes.peakLo.map { $0 - lowestVal })

        (graffeineView.layer(id: LayerID.wick) as? GraffeineBarLayer)?
            .unitSubdivision = (wickData.values.count > 20)
                ? GraffeineLayer.UnitSubdivision(index:  6, width: .percentage(0.08))
                : GraffeineLayer.UnitSubdivision(index: 10, width: .percentage(0.05))

        graffeineView.layer(id: LayerID.wick)?
            .setData( wickData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.candle)?.unitFill.colors = lanes.colors

        graffeineView.layer(id: LayerID.candle)?
            .setData( candleData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.leftGutter)?.data = candleData
    }
}
