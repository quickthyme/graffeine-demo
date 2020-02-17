import UIKit
import Graffeine

class ProgressIndicatorsCell: UITableViewCell, DemoCell {

    typealias BarID = ProgressIndicatorsConfigBar.ID
    typealias RadID = ProgressIndicatorsConfigRad.ID
    typealias IndID = ProgressIndicatorsConfigInd.ID

    @IBOutlet weak var progBar: GraffeineView!
    @IBOutlet weak var progRad: GraffeineView!
    @IBOutlet weak var progInd: GraffeineView!

    @IBAction func waitBar(_ sender: AnyObject?) {
        progBar.layer(id: BarID.progress)!.setData(GraffeineData(valueMax: 100, valuesHi: [0]),
                                                   semantic: .reload)
        delay(0.5, self.updateProgBar(100))
    }

    @IBAction func waitRad(_ sender: AnyObject?) {
        progRad.layer(id: RadID.progress)!.setData(GraffeineData(valueMax: 100, valuesHi: [0]),
                                                   semantic: .reload)
        delay(0.5, self.updateProgRad(100))
    }

    @IBAction func waitInd(_ sender: AnyObject?) {
        waitIndIsAnimating = !waitIndIsAnimating
        let index = (waitIndIsAnimating) ? 0 : nil
        progInd.select(index: index)
    }

    var waitIndIsAnimating: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func delay(_ delay: TimeInterval, _ action: @autoclosure @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
    }

    func barAnimator(_ duration: TimeInterval) -> GraffeineBarDataAnimating? {
        return GraffeineAnimation.Data.Bar.Grow(duration: duration, timing: .linear)
    }

    func radAnimator(_ duration: TimeInterval) -> GraffeineRadialSegmentDataAnimating? {
        return GraffeineAnimation.Data.RadialSegment.Automatic(duration: duration, timing: .linear)
    }

    func indAnimator(_ duration: TimeInterval) -> GraffeineRadialSegmentDataAnimating? {
        return GraffeineAnimation.Data.RadialSegment.Automatic(duration: duration, timing: .linear)
    }

    func applyData() {
    }

    func updateProgBar(_ val: Double) {
        progBar.layer(id: BarID.progress)!.mask?.bounds = progBar.layer(id: BarID.track)!.bounds
        let data = GraffeineData(valueMax: 100, valuesHi: [val])
        progBar.layer(id: BarID.progress)!.setData(data, semantic: .next)
    }

    func updateProgRad(_ val: Double) {
        let data = GraffeineData(valueMax: 100, valuesHi: [val])
        progRad.layer(id: RadID.progress)!.setData(data, semantic: .next)
    }
}
