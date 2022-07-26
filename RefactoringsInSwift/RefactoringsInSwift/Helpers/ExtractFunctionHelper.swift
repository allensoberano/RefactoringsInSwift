//
//  ExtractFunctionHelper.swift
//  RefactoringsInSwift
//
//  Created by Allen Soberano on 7/26/22.
//

import Foundation

struct Invoice {
    let customer: String
    let orders: [Orders]
    var dueDate: Date

}

struct Orders {
    let amount: Int
}

struct Today {
    let date = Date()
    let dateFormatter = DateFormatter()


    func today() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    func getFullYear() -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }

    func getMonth() -> String {
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }

    func getMonthNumber() -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        if let month = components.month {
            return month
        }
        return nil
    }

    func getDate() -> Int? {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day
    }
}
