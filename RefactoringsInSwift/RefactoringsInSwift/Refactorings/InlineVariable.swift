//
//  InlineVariable.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//

import Foundation

/// Inline the variable when the variable is getting in the way and doesn't add value
struct InlineVariable {
    func isLargeOrder(anOrder: Order) -> Bool {
        let basePrice = anOrder.basePrice
        return basePrice > 1000
    }
}

struct RefactoredInlineVariable {
    func isLargeOrder(anOrder: Order) -> Bool {
        return anOrder.basePrice > 1000
    }
}
