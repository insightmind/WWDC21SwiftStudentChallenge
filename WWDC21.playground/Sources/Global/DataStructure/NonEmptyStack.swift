// Copyright © 2021 Niklas Buelow. All rights reserved.

import Foundation

internal struct NonEmptyStack<Element> {
    // MARK: - Properties
    private(set) var base: Element
    private var stack: [Element]

    // MARK: - Public Properties
    var count: Int { 1 + stack.count }
    var head: Element { stack.last ?? base }

    // MARK: - Initialization
    init(base: Element) {
        self.base = base
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
        return [base] + stack
    }
}
