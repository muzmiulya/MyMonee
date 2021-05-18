//
//  UsageHistory.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//
import Foundation

protocol Counting {
   func countBalance() -> Int
}

struct UsageHistory {
    var ids: String?
    var usageName: String?
    var usagePrice: Int?
    var usageDate: String?
    var status: Bool?
    init(ids: String?, usageName: String?, usagePrice: Int?, usageDate: String?, status: Bool?) {
        self.ids = ids
        self.usageName = usageName
        self.usagePrice = usagePrice
        self.usageDate = usageDate
        self.status = status
    }
}
var usageHistory: [UsageHistory] = [
//    UsageHistory(ids: "fe432", usageName: "Bayar Listrik", usagePrice: 256000, usageDate: "Feb 02 2021 at 07:30 AM", status: false),
//    UsageHistory(ids: "kg092", usageName: "Gaji Februari", usagePrice: 1250000, usageDate: "April 15 2021 at 10:31 AM", status: true)
]

class Usage {
    var usage: UsageHistory
    init(usage: UsageHistory) {
        self.usage = usage
    }
    func addNewUsage() {
        usageHistory.append(usage)
    }
}

class Balance: Counting {
    func countBalance() -> Int {
        let arrayWithNoOptionals = usageHistory.compactMap { $0 }
        let arrayTrue = arrayWithNoOptionals.filter({$0.status == true}).map({($0.usagePrice ?? 0)}).reduce(0, +)
        let arrayFalse = arrayWithNoOptionals.filter({$0.status == false}).map({($0.usagePrice ?? 0)}).reduce(0, +)
        let total = arrayTrue - arrayFalse
        return total
    }
}
