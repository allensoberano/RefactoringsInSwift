//
//  ExtractVariable.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//

import Foundation

/// Local variables may help break expression down into something more manageable.
/// Naming complex piece of logic allows better understanding of what is happening
struct PreExtractVariable {
    func price(order: Order) -> Double? {
        //price is base price - quantity discount + shipping
        return order.quantity * order.itemPrice -
        ([0, order.quantity - 500].max() ?? 0) * order.itemPrice * 0.05 +
        ([order.quantity * order.itemPrice * 0.1, 100].min() ?? 0)
    }
}

struct ExtractVariable {
    func price(order: Order) -> Double? {
        let basePrice = order.quantity * order.itemPrice
        let quantityDiscount = ([0, order.quantity - 500].max() ?? 0) * order.itemPrice * 0.05
        let shipping = [basePrice * 0.1, 100].min() ?? 0

        return basePrice - quantityDiscount + shipping
    }
}

// MARK: - Example With a Class
/// In this case, extract the same names, realize that the names apply to the Order as a whole, not just the calculation of the price. Since they apply to the whole order,
/// extract the names as methods rather than variables.

class OrderClass {
    let record: Record

    var quantity: Double { return record.quantity }

    var itemPrice: Double { return record.itemPrice }

    var price: Double {
        return quantity * itemPrice -
        ([0, quantity - 500].max() ?? 0) * itemPrice * 0.05 +
        ([quantity * itemPrice * 0.1, 100].min() ?? 0)
    }

    init(aRecord: Record){
        record = aRecord
    }
}

class RefactoredOrderClass {
    let record: Record
    var quantity: Double { return record.quantity }
    var itemPrice: Double { return record.itemPrice }

    var price: Double {
        return basePrice - quantityDiscount + shipping
    }

    var basePrice: Double { return quantity * itemPrice }
    var quantityDiscount: Double { return ([0, quantity - 500].max() ?? 0) * itemPrice * 0.05 }
    var shipping: Double { return ([quantity * itemPrice * 0.1, 100].min() ?? 0)}

    init(aRecord: Record){
        record = aRecord
    }
}
