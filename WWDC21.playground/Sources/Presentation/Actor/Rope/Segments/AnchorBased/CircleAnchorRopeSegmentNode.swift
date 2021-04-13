// Copyright © 2021 Niklas Buelow. All rights reserved.

import SpriteKit

final class CircleAnchorSegmentNode: RopeSegmentNode {
    private let startPointToAnchorDirection: CGPoint
    private let enterDirection: CGPoint
    private let clockwise: Bool

    private let firstShapeNode: SKShapeNode = .init(circleOfRadius: 10)
    private let secondShapeNode: SKShapeNode = .init(circleOfRadius: 10)
    private let thirdShapeNode: SKShapeNode = .init(circleOfRadius: 10)

    // MARK: - Initialization
    init(startPoint: CGPoint, startPointToAnchorDirection: CGPoint, enterDirection: CGPoint) {
        self.startPointToAnchorDirection = startPointToAnchorDirection
        self.enterDirection = enterDirection

        let inverseStartPointToAnchor = startPointToAnchorDirection.normalized().scalarMultiply(-1)
        let clockwiseDirection = CGPoint(
            x: inverseStartPointToAnchor.x * cos(.pi / 2) - inverseStartPointToAnchor.y * sin(.pi / 2),
            y: inverseStartPointToAnchor.x * sin(.pi / 2) + inverseStartPointToAnchor.y * cos(.pi / 2)
        )

        print("Clockwise Direction: \(clockwiseDirection), Anti: \(clockwiseDirection.scalarMultiply(-1))")
        print("Enter Direction: \(enterDirection)")

        if enterDirection.difference(to: clockwiseDirection).length() < enterDirection.difference(to: clockwiseDirection.scalarMultiply(-1)).length() {
            clockwise = true
            print("IS CLOCKWISE")
        } else {
            clockwise = false
            print("IS ANTICLOCKWISE")
        }

        super.init(startPoint: startPoint)

        addChild(firstShapeNode)
        addChild(secondShapeNode)
        addChild(thirdShapeNode)
    }

    // MARK: - Drawing
    override func drawPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: startPoint)

        print("CIRCLE: Start: \(startPoint), End: \(endPoint)")

        let tangentPoint = tangentPointOnCircle(for: startPoint.difference(to: endPoint), circleCenter: startPoint.add(startPointToAnchorDirection), radius: startPointToAnchorDirection.length())

        print("Enter Radius: \(radiusOnCircle(for: startPoint, circleCenter: startPoint.add(startPointToAnchorDirection), clockwise: clockwise) + .pi) == \(3 * Double.pi / 2)")
        print("Exit Radius: \(radiusOnCircle(for: startPoint.add(tangentPoint.first), circleCenter: startPoint.add(startPointToAnchorDirection), clockwise: clockwise)) == \(0)")

        path.addArc(
            withCenter: startPoint.add(startPointToAnchorDirection),
            radius: startPointToAnchorDirection.length(),
            startAngle: 3 * .pi / 2,
            endAngle: 0,
            clockwise: clockwise
        )

        firstShapeNode.position = startPoint.add(tangentPoint.first)
        firstShapeNode.fillColor = .cyan
        secondShapeNode.position = startPoint.add(tangentPoint.second)
        firstShapeNode.fillColor = .green
        thirdShapeNode.position = endPoint
        thirdShapeNode.fillColor = .black


        //path.addLine(to: endPoint)


//        let firstDirection = startPoint.vector(to: bendAnchor)
//        let firstCurveAnchor = CGPoint(length: firstDirection.length() - curveRadius / 2, direction: firstDirection)
//        let secondDirection = bendAnchor.vector(to: endPoint)
//        let secondCurveAnchor = firstDirection.add(CGPoint(length: curveRadius / 2, direction: secondDirection))
//
//        path.addLine(to: firstCurveAnchor)
//        path.addQuadCurve(to: secondCurveAnchor, controlPoint: startPoint.vector(to: bendAnchor))
//        path.addLine(to: startPoint.vector(to: endPoint))
        return path.cgPath
    }

    // MARK: - Helper Methods
    private func radiusOnCircle(for point: CGPoint, circleCenter: CGPoint, clockwise: Bool) -> CGFloat {
        let pointDirection = circleCenter.difference(to: point).normalized()
        let referenceDirection = clockwise ? CGPoint(x: -1, y: 0).normalized() : CGPoint(x: 1, y: 0).normalized() // Direction for 0*pi
        return acos(referenceDirection.dot(pointDirection))
    }

    private func tangentPointOnCircle(for referencePoint: CGPoint, circleCenter: CGPoint, radius: CGFloat) -> (first: CGPoint, second: CGPoint) {
        let refPoint = circleCenter.difference(to: referencePoint)

        let radiusSquared = pow(radius, 2)

        let midnightA = pow(refPoint.x, 2) + pow(refPoint.y, 2)
        let midnightB = 2 * radiusSquared * refPoint.x
        let midnightC = radiusSquared * (radiusSquared - pow(refPoint.y, 2))

        let discriminant = pow(midnightB, 2) - 4 * midnightA * midnightC
        guard discriminant >= 0 else {
            print("ERROR: Discriminent would cause imaginary coordinate. CircleAnchorSegmentNode.tangentPointOnCircle aborting!")
            return (first: .zero, second: .zero)
        }

        let aPlus = (-midnightB + sqrt(discriminant)) / (2 * midnightA)
        let aMinus = (-midnightB - sqrt(discriminant)) / (2 * midnightA)

        let bPlus = sqrt(radiusSquared - pow(aPlus, 2))
        let bMinus = sqrt(radiusSquared - pow(bPlus, 2))

        return (first: .init(x: aPlus, y: bPlus), second: .init(x: aMinus, y: bMinus))
    }
}
