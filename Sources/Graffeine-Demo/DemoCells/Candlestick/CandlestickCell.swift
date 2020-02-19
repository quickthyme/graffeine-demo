import UIKit
import Graffeine

class CandlestickCell: UITableViewCell, DemoCell {

    typealias LayerID = CandlestickConfig.ID
    typealias GutterLayerID = CandlestickGutterConfig.ID

    private lazy var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        return nf
    }()

    private lazy var calendar: Calendar = Calendar(identifier: .gregorian)

    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()

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
        graffeineView.onSelect = { _, selection in
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

    func getDataLanes(completion: @escaping (TradingDayLanes) -> ()) {
        if self.lanes == nil {
            self.lanes = TradingDayLanes.import(self.dataSet)
        }
        completion(self.lanes!)
    }

    func applyData() {
        applyData(animated: false)
    }

    func applyData(animated: Bool) {

        self.getDataLanes { lanes in
            let nf = self.numberFormatter
            let cal = self.calendar
            let df = self.dateFormatter
            let selectedIndex = self.selectedIndex

            let today = cal.startOfDay(for: Date())
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

            let semantic: GraffeineData.AnimationSemantic = (animated) ? .reload : .notAnimated

            self.leftGutterView.layer(id: GutterLayerID.mainGutter)?.data = gutterLabelData
            self.graffeineView.layer(id: LayerID.candle)?.unitFill.colors = lanes.colors

            self.graffeineView.layerDataInput = [
                (layerId: LayerID.wick,        data: wickData,   semantic: semantic),
                (layerId: LayerID.candle,      data: candleData, semantic: semantic),
                (layerId: LayerID.candleLabel, data: candleData, semantic: semantic)
            ]

            if let selectedIndex = self.selectedIndex {
                self.infoLabel.text = lanes.labels[selectedIndex]
            } else {
                self.infoLabel.text = ""
            }
        }
    }
}
