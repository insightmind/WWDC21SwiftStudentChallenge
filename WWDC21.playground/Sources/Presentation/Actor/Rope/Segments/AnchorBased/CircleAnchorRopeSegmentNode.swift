// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class CircleAnchorSegmentNode: RopeSegmentNode {
    private let circleCenter: CGPoint
    private var subdivisionCount: Int = 0
    private let subdivision: CGFloat = 25
    private var cycleCount: Int { subdivisionCount / Int(subdivision) }

    // MARK: - Debug Nodes
    // MARK: - Initialization
    init(circleCenter: CGPoint) {
        self.circleCenter = circleCenter
        super.init()
    }

    // MARK: - Drawing
    override func drawPath(path: CGMutablePath) -> CGMutablePath {
        let clockwise = CircleAlgorithm.isTangentClockwise(tangentPoint: circleCenter.difference(to: path.currentPoint), tangentDirection: path.currentSlope)
        let radius = circleCenter.difference(to: path.currentPoint).length()

//        for _ in 0 ..< (circleCount / 2) {
//            let startAngle = angleOnCircle(for: path.currentPoint, circleCenter: circleCenter)
//            path.addRelativeArc(center: circleCenter, radius: radius, startAngle: startAngle, delta: clockwise ? -.pi : .pi)
//        }

        return calculateArc(path: path, radius: radius, isClockwise: clockwise)
    }

    private func calculateArc(path: CGMutablePath, radius: CGFloat, isClockwise clockwise: Bool) -> CGMutablePath {
        var path = path

        // Find valid exit points for the circle
        guard let tangentPoint = resolveTangentPoint(clockwise: clockwise, radius: radius) else {
            path.addLine(to: endPoint)
            return path
        }

        let startAngle = CircleAlgorithm.angleOnCircle(for: path.currentPoint, circleCenter: circleCenter)
        let startDirection = circleCenter.difference(to: path.currentPoint).normalized()
        let endDirection = tangentPoint.normalized()
        let endAngle = acos(startDirection.dot(endDirection))

        if endAngle >= .pi / subdivision {
            path.addRelativeArc(center: circleCenter, radius: radius, startAngle: startAngle, delta: clockwise ? -.pi / subdivision : .pi / subdivision)
            path = calculateArc(path: path, radius: radius, isClockwise: clockwise)
            subdivisionCount += 1
        } else {
            path.addRelativeArc(center: circleCenter, radius: radius, startAngle: startAngle, delta: clockwise ? -endAngle : endAngle)
            interactableStartPoint = path.currentPoint
            path.addLine(to: endPoint)
        }

        return path
    }

    private func resolveTangentPoint(clockwise: Bool, radius: CGFloat) -> CGPoint? {
        guard let tangentPoint = CircleAlgorithm.tangentPointOnCircle(for: circleCenter.difference(to: endPoint), radius: radius) else { return nil }
        let firstTangentDirection = circleCenter
            .add(tangentPoint.first)
            .difference(to: endPoint)
            .normalized()

        let isFirstTangentClockwise = CircleAlgorithm.isTangentClockwise(tangentPoint: tangentPoint.first, tangentDirection: firstTangentDirection)

        if clockwise {
            return isFirstTangentClockwise ? tangentPoint.first : tangentPoint.second
        } else {
            return isFirstTangentClockwise ? tangentPoint.second : tangentPoint.first
        }
    }
}
