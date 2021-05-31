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

struct UsageHistory: Codable {
    var ids: String?
    var usageName: String?
    var usagePrice: Int?
    var usageDate: String?
    var usageDateUpdated: String?
    var status: Bool
    init(ids: String, usageName: String, usagePrice: Int, usageDate: String, usageDateUpdated: String, status: Bool) {
        self.ids = ids
        self.usageName = usageName
        self.usagePrice = usagePrice
        self.usageDate = usageDate
        self.usageDateUpdated = usageDateUpdated
        self.status = status
    }
    enum CodingKeys: String, CodingKey {
        case ids
        case usageName
        case usagePrice
        case usageDate
        case usageDateUpdated
        case status
    }
}
var usageHistory: [UsageHistory] = []
var usageObject: UsageHistory = UsageHistory(ids: "", usageName: "", usagePrice: 0, usageDate: "", usageDateUpdated: "", status: true)

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

