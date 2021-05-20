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
    var usageDate: Date?
    var status: Bool?
    init(ids: String?, usageName: String?, usagePrice: Int?, usageDate: Date?, status: Bool?) {
        self.ids = ids
        self.usageName = usageName
        self.usagePrice = usagePrice
        self.usageDate = usageDate
        self.status = status
    }
}
var usageHistory: [UsageHistory] = []

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

func getMethod() {
        guard let url = URL(string: "https://60a587bcc0c1fd00175f4035.mockapi.io/api/v1/transaction") else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
