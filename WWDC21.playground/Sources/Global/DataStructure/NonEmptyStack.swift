// Copyright © 2021 Niklas Buelow. All rights reserved.

import Foundation

internal struct NonEmptyStack<Element> {
    // MARK: - Properties
    private var baseElement: Element
    private var stack: [Element]

    // MARK: - Public Properties
    var count: Int { 1 + stack.count }
    var head: Element { stack.last ?? baseElement }

    // MARK: - Initialization
    init(base: Element) {
        self.baseElement = base
        self.stack = []
    }

    // MARK: - Methods
    mutating func push(_ element: Element) {
        stack.append(element)
    }

    mutating func pop() -> Element? {
        stack.popLast()
    }

    // MARK: - Helper Methods
    func toArray() -> [Element] {
        return [baseElement] + stack
    }
}
