//
//  InlineFunction.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//
// Use when code uses too much indirection
// or when the bodyis as clear as the name

import Foundation

struct Driver {
    let numberOfLateDeliveries = Int.random(in: 1..<10)
}
/// Mechanics
/// Check that this isn’t a polymorphic method.
///  If this is a method in a class, and has subclasses that override it, then I can’t inline it.
/// Find all the callers of the function.
/// Replace each call with the function’s body.
/// Test after each replacement.
///     The entire inlining doesn’t have to be done all at once. If some parts of the inline are tricky, they can be done gradually as opportunity permits. Remove the function definition.
struct PreInlineFunctionVariationOne {
    func rating(aDriver: Driver) -> Int {
        return moreThanFiveLateDeliveries(aDriver) ? 2 : 1
    }

    func moreThanFiveLateDeliveries(_ aDriver: Driver) -> Bool {
        return aDriver.numberOfLateDeliveries > 5
    }
}

// MARK: - Refactored Inline Function Variation 1 -

struct InlineFunctionVariationOne {
    func rating(aDriver: Driver) -> Int {
        return aDriver.numberOfLateDeliveries > 5 ? 2 : 1
    }
}



// MARK: - Inline Variation 2 -
//

struct Customer {
    let name: String
    let location: String
}

struct PreInlineFunctionVariationTwo {
    func reportLines(aCustomer: Customer) -> [String] {
        var lines: [String] = []
        gatherCustomerData(&lines, aCustomer)
        return lines
    }

    func gatherCustomerData(_ lines: inout [String], _ aCustomer: Customer){
        lines.append(contentsOf: ["name", aCustomer.name])
        lines.append(contentsOf: ["location", aCustomer.location])
    }
}

// MARK: - Refactored Inline Variation 2
struct InlineFunctionVariationTwo {
    func reportLines(aCustomer: Customer) -> [String] {
        var lines: [String] = []
        lines.append(contentsOf: ["name", aCustomer.name])
        lines.append(contentsOf: ["location", aCustomer.location])
        return lines
    }
}
