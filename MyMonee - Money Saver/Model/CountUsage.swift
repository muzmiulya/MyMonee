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
   func latestUsageCount(transaction: Transaction)
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
    CountUsage(usageName: "Uang Masuk", usagePrice: 0, status: true),
    CountUsage(usageName: "Uang Keluar", usagePrice: 0, status: false)
]

class CountSpending: LatestCount {
    func latestUsageCount(transaction: Transaction) {
        let arrayWithNoOptionals = usageHistory.compactMap { $0 }
        switch transaction {
        case .income:
            let incomeCount = arrayWithNoOptionals.filter({$0.status == true}).map({$0.usagePrice ?? 0}).reduce(0, +)
            latestUsage[0].usagePrice = incomeCount
        case .outcome:
            let outcomeCount = arrayWithNoOptionals.filter({$0.status == false}).map({$0.usagePrice ?? 0}).reduce(0, +)
            latestUsage[1].usagePrice = outcomeCount
        }
    }
}
