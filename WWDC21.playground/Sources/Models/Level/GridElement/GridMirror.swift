import Foundation

struct GridMirror: GridElement {
    var type: GridElementType { .mirror(self) }
    
    var position: GridPosition
    var initialRotation: GridDirection

    func generateNode() -> GridNode {
        return MirrorNode()
    }
}
