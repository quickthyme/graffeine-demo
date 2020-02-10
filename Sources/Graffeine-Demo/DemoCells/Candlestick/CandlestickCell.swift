import UIKit
import Graffeine

class CandlestickCell: UITableViewCell, DemoCell {

    typealias LayerID = CandlestickConfig.ID
    typealias GutterLayerID = CandlestickGutterConfig.ID
    typealias AnimationKey = CandlestickConfig.AnimationKey

    @IBOutlet weak var leftGutterView: GraffeineView!
    @IBOutlet weak var graffeineView: GraffeineView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var reloadButton: UIButton!

    @IBAction func reload(_ sender: UIButton?) {
        self.lanes = nil
        self.applyData(animated: true)
    }

    var minZoomWidth: CGFloat { return (self.bounds.size.width - 64) }
    var maxZoomWidth: CGFloat { return (self.bounds.size.width - 64) * 5 }

    var selectedIndex: Int? = nil
    var lanes: TradingDayLanes?

    override func awakeFromNib() {
        super.awakeFromNib()
        infoLabel.text = ""
        setupScrollZoom()
        graffeineView.onSelect = { selection in
            self.selectedIndex = selection?.data.selected.index
            self.applyData(animated: true)
        }
    }

    @IBAction func pinchHandler(_ recognizer: UIPinchGestureRecognizer?) {
        guard let recognizer = recognizer, let recognizerView = recognizer.view else { return }
        switch recognizer.state{
        case .began, .changed:
            if let content = recognizerView.subviews.first as? GraffeineView {
                let scale = (recognizer.scale <= 4) ? recognizer.scale : 4.0
                let suggestedWidth = widthConstraint.constant * scale
                let newWidth = min(maxZoomWidth, max(minZoomWidth, suggestedWidth))
                widthConstraint.constant = newWidth
                content.layoutSublayers(of: content.layer)
            }
        default: break
        }
        recognizer.scale = 1.0
    }

    func setupScrollZoom() {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(_:)))
        for r in scrollView.gestureRecognizers ?? [] { if (r is UIPinchGestureRecognizer) { r.isEnabled = false } }
        scrollView.addGestureRecognizer(recognizer)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        self.widthConstraint.constant = maxZoomWidth / 2
    }

    var dataSet: [TradingDay] {
        return TradingDay.generateRandom(numberOfDays: 45, lowest: 10, highest: 90)
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {

        if self.lanes == nil { self.lanes = TradingDayLanes.import(dataSet) }
        let lanes = self.lanes!

        let nf = NumberFormatter()
        nf.numberStyle = .currency

        let cal = Calendar.init(identifier: .gregorian)
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"

        let today = Date()
        let candleLabels: [String?] = lanes.hi
            .enumerated()
            .map({ let d = cal.date(byAdding: .day, value: 0 - $0.offset, to: today)
                return df.string(from: d!) })
            .reversed()

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
                                       labels: candleLabels,
                                       selectedIndex: selectedIndex)


        let wickData = GraffeineData(valueMax: maxVal - lowestVal,
                                     valuesHi: lanes.peakHi.map { $0 - lowestVal },
                                     valuesLo: lanes.peakLo.map { $0 - lowestVal },
                                     selectedIndex: selectedIndex)

        let animationKeys = (animated)
            ? (bar: AnimationKey.barMove, label: AnimationKey.labelMove)
            : nil

        leftGutterView.layer(id: GutterLayerID.mainGutter)?.data = gutterLabelData

        graffeineView.layer(id: LayerID.wick)?
            .setData( wickData, animationKey: animationKeys?.bar )

        graffeineView.layer(id: LayerID.candle)?
            .unitFill.colors = lanes.colors

        graffeineView.layer(id: LayerID.candle)?
            .setData( candleData, animationKey: animationKeys?.bar )

        graffeineView.layer(id: LayerID.candleLabel)?
            .setData( candleData, animationKey: animationKeys?.label )

        if let selectedIndex = self.selectedIndex {
            infoLabel.text = lanes.labels[selectedIndex]
        } else {
            infoLabel.text = ""
        }
    }
}
