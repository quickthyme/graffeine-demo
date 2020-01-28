import UIKit
import Graffeine

extension CandlestickCell {

    struct TradingDay {
        let open: Double
        let close: Double
        let peakHi: Double
        let peakLo: Double

        static func generateRandom(numberOfDays: Int, lowest: Double, highest: Double) -> [TradingDay] {
            return Array(0..<numberOfDays).reduce([], { result, _ in
                let yesterdayClose = result.last?.close ?? rnd(min: lowest, max: highest)
                let todayOpen = yesterdayClose
                let todayClose = rnd(min: lowest, max: highest)
                let hi = max(todayOpen, todayClose)
                let lo = min(todayOpen, todayClose)
                let range = hi - lo
                let peakHi = rnd(min: hi, max: min(hi + (range * 0.30), highest))
                let peakLo = rnd(min: max(lo - (range * 0.30), lowest), max: lo)
                return result + [TradingDay(open: todayOpen,
                                            close: todayClose,
                                            peakHi: peakHi,
                                            peakLo: peakLo)]
            })
        }

        private static func rnd(min: Double, max: Double) -> Double {
            return ceil(Double.random(in: min...max) * 100) / 100
        }
    }

    struct TradingDayLanes {
        let hi: [Double]
        let lo: [Double]
        let peakHi: [Double]
        let peakLo: [Double]
        let colors: [UIColor]
        let labels: [String]

        static func `import`(_ input: [TradingDay]) -> TradingDayLanes {
            let nf = NumberFormatter()
            nf.numberStyle = .currency

            func formatted(_ val: Double) -> String {
                return nf.string(from: NSNumber(value: val)) ?? ""
            }

            return input.reduce(TradingDayLanes(hi: [], lo: [], peakHi: [], peakLo: [], colors: [], labels: [])) {
                let didCloseHi = ($1.close > $1.open)
                let hi = (didCloseHi) ? $1.close : $1.open
                let lo = (didCloseHi) ? $1.open : $1.close
                let color: UIColor = (didCloseHi) ? .green : .red
                let label = " open:\t\(formatted($1.open))\n close:\t\(formatted($1.close))\n"
                    + " hi:\t\t\(formatted($1.peakHi))\n lo:\t\t\(formatted($1.peakLo))\n"
                return TradingDayLanes(hi: $0.hi + [hi],
                                       lo: $0.lo + [lo],
                                       peakHi: $0.peakHi + [$1.peakHi],
                                       peakLo: $0.peakLo + [$1.peakLo],
                                       colors: $0.colors + [color],
                                       labels: $0.labels + [label])
            }
        }
    }
}
