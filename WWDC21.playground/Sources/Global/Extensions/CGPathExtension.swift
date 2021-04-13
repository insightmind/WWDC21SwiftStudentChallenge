import CoreGraphics

extension CGPath {
    var nodePoints: [CGPoint] {
        var points: [CGPoint] = []

        self.applyWithBlock { element in
            switch element.pointee.type {
            case .moveToPoint, .addLineToPoint:
                points.append(element.pointee.points.pointee)

            case .addQuadCurveToPoint:
                points.append(element.pointee.points.pointee)
                points.append(element.pointee.points.advanced(by: 1).pointee)

            case .addCurveToPoint:
                points.append(element.pointee.points.pointee)
                points.append(element.pointee.points.advanced(by: 1).pointee)
                points.append(element.pointee.points.advanced(by: 2).pointee)

            case .closeSubpath:
                break

            @unknown default:
                break
            }
        }

        return points
    }

    var currentSlope: CGPoint {
        let points = nodePoints
        guard points.count >= 2 else { return .zero }
        let lastPoint = points[points.count - 1]
        let previousPoint = points[points.count - 2]

        return previousPoint.difference(to: lastPoint)
    }
}
