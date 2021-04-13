// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class CircleAnchorSegmentNode: RopeSegmentNode {
    private let circleCenter: CGPoint
    private let radius: CGFloat
    private let enterDirection: CGPoint

    // MARK: - Initialization
    init(circleCenter: CGPoint, radius: CGFloat, enterDirection: CGPoint) {
        self.circleCenter = circleCenter
        self.radius = radius
        self.enterDirection = enterDirection.normalized()

        super.init()
    }

    // MARK: - Drawing
    override func drawPath(path: CGMutablePath) -> CGMutablePath {
        let relativeStartPoint = circleCenter.difference(to: path.currentPoint)
        let clockwise = isClockwise(tangentPoint: circleCenter.difference(to: path.currentPoint), tangentDirection: enterDirection)

        // Find valid exit points for the circle
        guard let tangentPoint = resolveTangentPoint(clockwise: clockwise) else {
            path.addLine(to: endPoint)
            return path
        }

        let startAngle = angleOnCircle(for: path.currentPoint, circleCenter: circleCenter)
        let startDirection = relativeStartPoint.normalized()
        let endDirection = tangentPoint.normalized()
        let angle = angleBetween(first: startDirection, second: endDirection)

        //let radiusSquared = pow(radius, 2)
        //let angle = acos((2 * radiusSquared - pow(relativeStartPoint.difference(to: tangentPoint).length(), 2)) / (2 * radiusSquared))
        //path.addArc(center: circleCenter, radius: radius, startAngle: startAngle, endAngle: startAngle + angle, clockwise: !clockwise)
        print("Start: \(startAngle / .pi) -> End \((.pi - angle) / .pi)")
        print("Clockwise: \(clockwise)")
        path.addRelativeArc(center: circleCenter, radius: radius, startAngle: startAngle, delta: clockwise ? -(angle + .pi) : (angle + .pi))
        path.addLine(to: endPoint)
        return path
    }

    private func resolveTangentPoint(clockwise: Bool) -> CGPoint? {
        guard let tangentPoint = tangentPointOnCircle(for: circleCenter.difference(to: endPoint), radius: radius) else { return nil }
        let firstTangentDirection = circleCenter
            .add(tangentPoint.first)
            .difference(to: endPoint)
            .normalized()

        let isFirstTangentClockwise = isClockwise(tangentPoint: tangentPoint.first, tangentDirection: firstTangentDirection)

        if clockwise {
            return isFirstTangentClockwise ? tangentPoint.first : tangentPoint.second
        } else {
            return isFirstTangentClockwise ? tangentPoint.second : tangentPoint.first
        }
    }

    // MARK: - Helper Methods
    private func angleOnCircle(for point: CGPoint, circleCenter: CGPoint) -> CGFloat {
        return angleBetween(first: .init(x: 1, y: 0), second: circleCenter.difference(to: point).normalized())
    }

    private func angleBetween(first firstVector: CGPoint, second secondVector: CGPoint) -> CGFloat {
        let first = firstVector.normalized()
        let second = secondVector.normalized()
        return atan2(first.x * second.y - first.y * second.x, first.x * second.x - first.y * second.y)
    }

    private func tangentPointOnCircle(for refPoint: CGPoint, radius: CGFloat) -> (first: CGPoint, second: CGPoint)? {
        let radiusSquared = pow(radius, 2)

        let midnightA = pow(refPoint.x, 2) + pow(refPoint.y, 2)
        let midnightB = -2 * radiusSquared * refPoint.x
        let midnightC = radiusSquared * (radiusSquared - pow(refPoint.y, 2))

        let discriminant = pow(midnightB, 2) - 4 * midnightA * midnightC
        guard discriminant >= 0 else {
            print("ERROR: Discriminent would cause imaginary coordinate. CircleAnchorSegmentNode.tangentPointOnCircle aborting!")
            return nil
        }

        let aPlus = (-midnightB + sqrt(discriminant)) / (2 * midnightA)
        let aMinus = (-midnightB - sqrt(discriminant)) / (2 * midnightA)

        let bPlus = (radiusSquared - refPoint.x * aPlus) / refPoint.y
        let bMinus = (radiusSquared - refPoint.x * aMinus) / refPoint.y
        return (first: .init(x: aPlus, y: bPlus), second: .init(x: aMinus, y: bMinus))
    }

    private func isClockwise(tangentPoint: CGPoint, tangentDirection: CGPoint) -> Bool {
        let angle = atan2(
            tangentPoint.x * tangentDirection.y - tangentPoint.y * tangentDirection.x,
            tangentPoint.x * tangentDirection.x - tangentPoint.y * tangentDirection.y
        )

        return angle < 0
    }
}
