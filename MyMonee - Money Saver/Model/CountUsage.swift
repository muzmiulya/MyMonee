//
//  CountUsage.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 16/05/21.
//

import Foundation

enum Transaction {
    case income
    case outcome
}

protocol LatestCount {
   func latestUsageCount(transaction: Transaction) -> Int
}

struct CountUsage {
    var usageName: String?
    var usagePrice: Int?
    var status: Bool?
    internal init(usageName: String?, usagePrice: Int?, status: Bool?) {
        self.usageName = usageName
        self.usagePrice = usagePrice
        self.status = status
    }
}

var latestUsage: [CountUsage] = [
    CountUsage(usageName: "Uang Masuk", usagePrice: 1250000, status: true),
    CountUsage(usageName: "Uang Keluar", usagePrice: 256000, status: false)
]

class CountSpending: LatestCount {
    func latestUsageCount(transaction: Transaction) -> Int {
        let arrayWithNoOptionals = latestUsage.compactMap { $0 }
        switch transaction {
        case .income:
            return arrayWithNoOptionals.filter({$0.status == true}).map({$0.usagePrice ?? 0}).reduce(0, +)
        case .outcome:
            return arrayWithNoOptionals.filter({$0.status == false}).map({$0.usagePrice ?? 0}).reduce(0, +)
        }
    }
}
