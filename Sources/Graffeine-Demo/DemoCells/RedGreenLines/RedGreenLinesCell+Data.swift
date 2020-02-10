import UIKit
import Graffeine

extension RedGreenLinesCell {

    struct Data {
        var greenHistorical: [Double?] = []
        var greenProjected: [Double?] = []
        var redHistorical: [Double?] = []
        var redProjected: [Double?] = []

        static func generateRandom() -> Data {
            var data = Data()
            data.greenHistorical = generateRandomValues(6, min: 14, max: 50)
            data.greenProjected = generateNilDoubles(5) + generateProjection(data.greenHistorical)
            data.redHistorical = generateRandomValues(6, min: 4, max: 40)
            data.redProjected = generateNilDoubles(5) + generateProjection(data.redHistorical)
            return data
        }

        static func generateNilDoubles(_ count: Int) -> [Double?] {
            return (0..<count).map { _ in return nil }
        }

        static func generateRandomValues(_ count: Int, min: Double, max: Double) -> [Double] {
            return (0..<count).map { _ in return normalized(Double.random(in: min...max)) }
        }

        static func normalized(_ input: Double) -> Double {
            return ceil(input * 100) / 100
        }

        static func generateProjection(_ input: [Double?]) -> [Double?] {
            let inputCount = input.count
            guard
                (inputCount > 1),
                let last = input[inputCount - 1],
                let before = input[inputCount - 2]
                else { return [nil] }
            let proj = last + (last - before)
            return [last, proj]
        }
    }
}
