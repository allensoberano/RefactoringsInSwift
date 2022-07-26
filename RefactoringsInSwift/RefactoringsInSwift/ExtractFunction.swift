//
//  Extract Function.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//

import Foundation

struct ExtractFunction {

    func printOwing(invoice: Invoice){
        var invoice = invoice
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y, M, d"

        var outstanding = 0

        print("***********************");
        print("**** Customer Owes ****");
        print("***********************");

        // calculate outstanding
        for o in invoice.orders {
            outstanding += o.amount
        }

        // record due date
        let today = Today()
        if let dueDate = dateFormatter.date(from: "\(today.getFullYear()), \(today.getMonth()), \(today.getDate()! + 30)") {
            invoice.dueDate = dueDate
        }

        // print details
        print("name: $\(invoice.customer)")
        print("amount: $\(outstanding)")
        print("due: $\(dateFormatter.string(from: invoice.dueDate))")
    }
}

// MARK: - 1. Refactored with Extracted Functions -
struct RefactoredExtractFunctionNoVariablesOutOfScope {

    func printOwing(invoice: Invoice){
        var invoice = invoice
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y, M, d"

        var outstanding = 0

        printBanner()

        // calculate outstanding
        for o in invoice.orders {
            outstanding += o.amount
        }

        // record due date
        let today = Today()
        if let dueDate = dateFormatter.date(from: "\(today.getFullYear()), \(today.getMonth()), \(today.getDate()! + 30)") {
            invoice.dueDate = dueDate
        }

        printDetails()

        func printDetails(){
            print("name: $\(invoice.customer)")
            print("amount: $\(outstanding)")
            print("due: $\(dateFormatter.string(from: invoice.dueDate))")
        }
    }

    func printBanner() {
        print("***********************")
        print("**** Customer Owes ****")
        print("***********************")
    }
}

// MARK: - 2. Refactored with Extracted Functions Using Local Variables -
struct RefactoredExtractFunctionUsingLocalVariables {

    func printOwing(invoice: Invoice){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y, M, d"

        var outstanding = 0
        printBanner()

        // calculate outstanding
        for o in invoice.orders {
            outstanding += o.amount
        }

        recordDueDate(invoice, dateFormatter)
        printDetails(invoice, outstanding, dateFormatter)
    }

    func printBanner() {
        print("***********************")
        print("**** Customer Owes ****")
        print("***********************")
    }

    func recordDueDate(_ invoice: Invoice, _ df: DateFormatter){
        var invoice = invoice
        let today = Today()
        if let dueDate = df.date(from: "\(today.getFullYear()), \(today.getMonth()), \(today.getDate()! + 30)") {
            invoice.dueDate = dueDate
        }
    }

    func printDetails(_ invoice: Invoice, _ outstanding: Int, _ df: DateFormatter){

        print("name: $\(invoice.customer)")
        print("amount: $\(outstanding)")
        print("due: $\(df.string(from: invoice.dueDate))")
    }
}

// MARK: - 3. Refactored with Extracted Functions Reassigning Local Variable -
struct RefactoredExtractFunctionReassigningLocalVariable {
// Used Split Variable & Slide Statments

    func printOwing(invoice: Invoice){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y, M, d"

        printBanner()
        let outstanding = calculateOutstanding(invoice)
        recordDueDate(invoice, dateFormatter)
        printDetails(invoice, outstanding, dateFormatter)
    }
}

extension RefactoredExtractFunctionReassigningLocalVariable {
    func printBanner() {
        print("***********************")
        print("**** Customer Owes ****")
        print("***********************")
    }

    func calculateOutstanding(_ invoice: Invoice) -> Int {
        var result = 0
        for o in invoice.orders {
            result += o.amount
        }
        return result
    }

    func recordDueDate(_ invoice: Invoice, _ df: DateFormatter){
        var invoice = invoice
        let today = Today()
        if let dueDate = df.date(from: "\(today.getFullYear()), \(today.getMonth()), \(today.getDate()! + 30)") {
            invoice.dueDate = dueDate
        }
    }

    func printDetails(_ invoice: Invoice, _ outstanding: Int, _ df: DateFormatter){

        print("name: $\(invoice.customer)")
        print("amount: $\(outstanding)")
        print("due: $\(df.string(from: invoice.dueDate))")
    }
}

