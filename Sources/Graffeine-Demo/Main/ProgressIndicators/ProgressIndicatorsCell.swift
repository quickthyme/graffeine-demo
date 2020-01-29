import UIKit
import Graffeine

class ProgressIndicatorsCell: UITableViewCell, DataAppliable {

    typealias BarID = ProgressIndicatorsConfigBar.ID
    typealias RadID = ProgressIndicatorsConfigRad.ID

    @IBOutlet weak var progBar: GraffeineView!
    @IBOutlet weak var progRad: GraffeineView!

    @IBAction func wait1(_ sender: AnyObject?) {
        progRad.layer(id: RadID.progress)!.setData(GraffeineData(valueMax: 100, values: [10]),
                                                   animator: radAnimator(0.22))
        delay(0.5, self.updateProgRad(100))
    }

    @IBAction func wait2(_ sender: AnyObject?) {
        progBar.layer(id: BarID.progress)!.setData(GraffeineData(valueMax: 100, values: [0]),
                                                   animator: barAnimator(0.22))
        delay(0.5, self.updateProgBar(100))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func delay(_ delay: TimeInterval, _ action: @autoclosure @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
    }

    func barAnimator(_ duration: TimeInterval) -> GraffeineBarDataAnimating? {
        return GraffeineAnimation.Data.Bar.Grow(duration: duration, timing: .linear)
    }

    func radAnimator(_ duration: TimeInterval) -> GraffeinePieDataAnimating? {
        return GraffeineAnimation.Data.Pie.Automatic(duration: duration, timing: .linear)
    }

    func applyData() {
    }

    func updateProgBar(_ val: Double) {
        progBar.layer(id: BarID.progress)!.mask?.bounds = progBar.layer(id: BarID.track)!.bounds
        let data = GraffeineData(valueMax: 100, values: [val])
        progBar.layer(id: BarID.progress)!.setData(data, animator: barAnimator(2.6))
    }

    func updateProgRad(_ val: Double) {
        let data = GraffeineData(valueMax: 100, values: [val])
        progRad.layer(id: RadID.progress)!.setData(data, animator: radAnimator(2.6))
    }
}
