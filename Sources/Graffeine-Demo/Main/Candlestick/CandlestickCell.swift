import UIKit
import Graffeine

class CandlestickCell: UITableViewCell, DataAppliable {

    typealias LayerID = CandlestickConfig.ID

    struct TradingDay {
        let open: Double
        let close: Double
        let peakHi: Double
        let peakLo: Double
    }

    struct TradingDayLanes {
        let hi: [Double]
        let lo: [Double]
        let peakHi: [Double]
        let peakLo: [Double]
        let colors: [UIColor]

        static func `import`(_ input: [TradingDay]) -> TradingDayLanes {
            return input.reduce(TradingDayLanes(hi: [], lo: [], peakHi: [], peakLo: [], colors: [])) {
                let didCloseHi = ($1.close > $1.open)
                let hi = (didCloseHi) ? $1.close : $1.open
                let lo = (didCloseHi) ? $1.open : $1.close
                let color: UIColor = (didCloseHi) ? .green : .red
                return TradingDayLanes(hi: $0.hi + [hi],
                                       lo: $0.lo + [lo],
                                       peakHi: $0.peakHi + [$1.peakHi],
                                       peakLo: $0.peakLo + [$1.peakLo],
                                       colors: $0.colors + [color])
            }
        }
    }
    
    @IBOutlet weak var graffeineView: GraffeineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        graffeineView.onSelect = { _ in
            self.dataSetIndex = (self.dataSetIndex + 1) % self.dataSets.count
            self.applyData(animated: true)
        }
    }

    func barAnimator(_ animated: Bool) -> GraffeineBarDataAnimating? {
        return (animated)
            ? GraffeineDataAnimators.Bar.Grow(duration: 0.8, timing: .easeOut)
            : nil
    }

    let dataSets: [[TradingDay]] = [
        [
            TradingDay(open: 12.1, close: 30.8, peakHi: 35.0, peakLo: 10.1),
            TradingDay(open: 30.8, close: 33.2, peakHi: 36.9, peakLo: 25.5),
            TradingDay(open: 33.2, close: 31.5, peakHi: 31.6, peakLo: 31.0),
            TradingDay(open: 31.5, close: 27.0, peakHi: 31.7, peakLo: 22.9),
            TradingDay(open: 27.0, close: 36.4, peakHi: 40.1, peakLo: 26.5)
        ],
        [
            TradingDay(open:   5.0, close:  2.0,  peakHi:  6.0, peakLo:  1.0),
            TradingDay(open:   2.0, close:  7.0,  peakHi:  9.0, peakLo:  1.0),
            TradingDay(open:   7.0, close:  9.0,  peakHi: 11.0, peakLo:  6.5),
            TradingDay(open:   9.0, close:  13.0, peakHi: 14.0, peakLo:  8.5),
            TradingDay(open:  13.0, close:  10.0, peakHi: 15.0, peakLo:  7.0)
        ]
    ]

    var dataSetIndex: Int = 0

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {

        let lanes = TradingDayLanes.import(dataSets[dataSetIndex])

        let nf = NumberFormatter()
        nf.numberStyle = .currency

        let maxVal = lanes.peakHi.max()! + 4
        let lowestVal = lanes.peakLo.min()!
        let midVal = lowestVal + ((maxVal - lowestVal) / 2)
        let vLabels = [
            "\(nf.string(from: NSNumber(value: maxVal * 1000))!)",
            "\(nf.string(from: NSNumber(value: midVal * 1000))!)",
            "\(nf.string(from: NSNumber(value: lowestVal * 1000))!)"
        ]

        let candleData = GraffeineData(valueMax: maxVal - lowestVal,
                                       valuesHi: lanes.hi.map { $0 - lowestVal },
                                       valuesLo: lanes.lo.map { $0 - lowestVal })

        let wickData = GraffeineData(valueMax: maxVal - lowestVal,
                                     valuesHi: lanes.peakHi.map { $0 - lowestVal },
                                     valuesLo: lanes.peakLo.map { $0 - lowestVal })

        graffeineView.layer(id: LayerID.wick)?
            .setData( wickData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.candle)?.unitFill.colors = lanes.colors

        graffeineView.layer(id: LayerID.candle)?
            .setData( candleData, animator: barAnimator(animated) )

        graffeineView.layer(id: LayerID.leftGutter)?
            .data = GraffeineData(labels: vLabels)
    }
}
