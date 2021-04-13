import CoreGraphics

enum CircleAlgorithm {
    /// Given a reference point P where two tangents of  a circle intersect, this method calculates the anchor points on the circle surface of these tangents.
    ///
    /// - Parameters:
    ///   - refPoint: The reference point at which both tangents intersect.
    ///   - radius: The radius of the circle
    ///
    /// - Returns: Both tangent anchorpoints or nil if the reference point lays within the circle.
    static func tangentPointOnCircle(for refPoint: CGPoint, radius: CGFloat) -> (first: CGPoint, second: CGPoint)? {
        let radiusSquared = pow(radius, 2)

        // The truly popular quadratic formula
        let midnightA = pow(refPoint.x, 2) + pow(refPoint.y, 2)
        let midnightB = -2 * radiusSquared * refPoint.x
        let midnightC = radiusSquared * (radiusSquared - pow(refPoint.y, 2))

        // If the discriminent is negative the term with the root will resolve to an imaginary unit and cannot be correctly interpreted for our purposes.
        let discriminant = pow(midnightB, 2) - 4 * midnightA * midnightC
        guard discriminant >= 0 else {
            print("ERROR: Discriminent would cause imaginary coordinate. CircleAnchorSegmentNode.tangentPointOnCircle aborting!")
            return nil
        }

        // For each solution we calculate the coordinates (a1,b1) and (a2,b2)
        let aPlus = (-midnightB + sqrt(discriminant)) / (2 * midnightA)
        let aMinus = (-midnightB - sqrt(discriminant)) / (2 * midnightA)

        let bPlus = (radiusSquared - refPoint.x * aPlus) / refPoint.y
        let bMinus = (radiusSquared - refPoint.x * aMinus) / refPoint.y

        return (first: .init(x: aPlus, y: bPlus), second: .init(x: aMinus, y: bMinus))
    }

    /// Calculates whether the tangent direction at the given tangent point shows into clockwise (true) or counterclockwise direction on the circle.
    /// 
    /// - Parameters:
    ///   - tangentPoint: The tangent point at which the tangent lays on.
    ///   - tangentDirection: The direction along the tangent to be determined for clockwise or counterclockwise direction
    ///
    /// - Returns: Returns true if the direction shows into clockwise direction.
    static func isTangentClockwise(tangentPoint: CGPoint, tangentDirection: CGPoint) -> Bool {
        // We expect the tangentDirection to be perpendicular to the center->tangentPoint vector.
        return tangentPoint.orientedAngle(to: tangentDirection) < 0
    }

    /// Returns the angle of the specified point relative to the circle center.
    ///
    /// - Parameters:
    ///   - point: The point at which the angle should be determined.
    ///   - circleCenter: The center of the circle on which the point lays.
    ///
    /// - Returns: Returns an oriented angle [-.pi ... 0 ... .pi]
    static func angleOnCircle(for point: CGPoint, circleCenter: CGPoint) -> CGFloat {
        return CGPoint(x: 1, y: 0).orientedAngle(to: circleCenter.difference(to: point).normalized())
    }
}
