//
//  ChangeFunctionDeclaration.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//

import Foundation

/// Change Function Declaration
/// If removing paramter, ensure it isn't referenced in the body of function
/// Change method declaration to desired declaration
/// Update Callers
///
/// May need to refactor body of function to do following extraction
/// Extract Fucntion of body / Apply inline function to old function

struct PreChangeFunctionDeclaration {
    func circum(radius: Double) -> Double {
        return 2 * .pi * radius
    }
}

struct ChangeFunctionDeclaration {
    func circumference(radius: Double) -> Double {
        return 2 * .pi * radius
    }
}

// MARK: - Using Migration Mechanics
//1
struct ChangeFunctionDeclarationTwo {
    func circum(radius: Double) -> Double {
        return circumference(radius)
    }

    func circumference(_ radius: Double) -> Double {
        return 2 * .pi * radius
    }
}

//2 Inline function
struct ChangeFunctionDeclarationTwoB {
    func circum(radius: Double) -> Double {
        return 2 * .pi * radius
    }
}

// MARK: - Adding a Parameter

// Need to add priority queue
class PreBook {
    var reservations: [Customer] = []

    func addReservation(customer: Customer) {
        reservations.append(customer)
    }
}
//1 extract function using temp name
class Book1 {
    var reservations: [Customer] = []

    func addReservation(customer: Customer) {
        zz_addReservation(customer: customer)
    }

    func zz_addReservation(customer: Customer){
        reservations.append(customer)
    }
}

//2 add param needed
class Book2 {
    var reservations: [Customer] = []

    func addReservation(customer: Customer) {
        zz_addReservation(customer, false)
    }

    func zz_addReservation(_ customer: Customer, _ isPriority: Bool){
        reservations.append(customer)
    }
}

//3 Introduce Assertion to check if used by caller
// so if you make a mistake and leave off new param, assert will catch it
class Book3 {
    var reservations: [Customer] = []

    func addReservation(customer: Customer) {
        zz_addReservation(customer, false)
    }

    func zz_addReservation(_ customer: Customer, _ isPriority: Bool){
        assert(isPriority == true || isPriority == false)
        reservations.append(customer)
    }
}

//4 Inline function on original
class Book4 {
    var reservations: [Customer] = []

    func addReservation(customer: Customer, isPriority: Bool) {
        reservations.append(customer)
    }
}

// MARK: Changing a Parameter to One of Its Properties

struct PreChangingParamToOneOfItsProperties {
    let someCustomers: [Customer] = []
    var newEnglanders: [Customer] {
        return someCustomers.filter { customer in inNewEngland(customer) }
    }

    func inNewEngland(_ aCustomer: Customer) -> Bool {
        return ["MA", "CT", "ME", "VT", "NH", "RI"].contains(aCustomer.address.state)
    }
}

//1 Change inNewEngland to take different param so its more usable
    // a: Extract variable for new param
struct ChangingParamToOneOfItsProperties {
    let someCustomers: [Customer] = []
    var newEnglanders: [Customer] {
        return someCustomers.filter { customer in inNewEngland(customer) }
    }

    func inNewEngland(_ aCustomer: Customer) -> Bool {
        let stateCode = aCustomer.address.state
        return ["MA", "CT", "ME", "VT", "NH", "RI"].contains(stateCode)
    }
}

// b: Extract Function to create new function
struct ChangingParamToOneOfItsProperties2 {
    let someCustomers: [Customer] = []
    var newEnglanders: [Customer] {
        return someCustomers.filter { customer in inNewEngland(customer) }
    }

    func inNewEngland(_ aCustomer: Customer) -> Bool {
        let stateCode = aCustomer.address.state
        return zzNEWinNewEngland(stateCode)
    }

    //
    func zzNEWinNewEngland(_ stateCode: String) -> Bool {
        return ["MA", "CT", "ME", "VT", "NH", "RI"].contains(stateCode)
    }
}

// c: Apply Inline Variable on input param in original function
// d: fold old function into it's callers replacing call to old function with new one
struct ChangingParamToOneOfItsProperties3 {
    let someCustomers: [Customer] = []
    var newEnglanders: [Customer] {
        return someCustomers.filter { customer in zzNEWinNewEngland(customer.address.state) } //d
    }

    func inNewEngland(_ aCustomer: Customer) -> Bool {
        return zzNEWinNewEngland(aCustomer.address.state) //c
    }

    func zzNEWinNewEngland(_ stateCode: String) -> Bool {
        return ["MA", "CT", "ME", "VT", "NH", "RI"].contains(stateCode)
    }
}

// e: Change name of new function to old one
struct ChangingParamToOneOfItsProperties4 {
    let someCustomers: [Customer] = []
    var newEnglanders: [Customer] {
        return someCustomers.filter { customer in inNewEngland(customer.address.state) }
    }

    //
    func inNewEngland(_ stateCode: String) -> Bool {
        return ["MA", "CT", "ME", "VT", "NH", "RI"].contains(stateCode)
    }
}
