//
//  dreams.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import Foundation

protocol AddNewDream {
    func addNewDream()
}

struct Dreams: Codable {
    var id: String?
    var dreamTitle: String?
    var dreamPriceGoal: Int?
    init(id: String, dreamTitle: String, dreamPriceGoal: Int) {
        self.id = id
        self.dreamTitle = dreamTitle
        self.dreamPriceGoal = dreamPriceGoal
    }
    enum CodingKeys: String, CodingKey {
        case id
        case dreamTitle
        case dreamPriceGoal
    }
}
var dreams: [Dreams] = []
var dreamObject: Dreams = Dreams(id: "", dreamTitle: "", dreamPriceGoal: 0)

class AddDream {
    var dream: Dreams
    init(dream: Dreams) {
        self.dream = dream
    }
    func addNewDream() {
        dreams.append(dream)
    }
}
