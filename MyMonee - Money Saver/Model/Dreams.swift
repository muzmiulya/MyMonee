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

struct Dreams {
    var id: String?
    var dreamTitle: String?
    var dreamPriceGoal: Int?
    init(id: String?, dreamTitle: String?, dreamPriceGoal: Int?) {
        self.id = id
        self.dreamTitle = dreamTitle
        self.dreamPriceGoal = dreamPriceGoal
    }
}
var dreams: [Dreams] = [
    Dreams(id: "0", dreamTitle: "Membeli Mobil", dreamPriceGoal: 200000000),
    Dreams(id: "1", dreamTitle: "Membeli Airpods baru", dreamPriceGoal: 1500000),
    Dreams(id: "2", dreamTitle: "Membeli Sepatu Adidas", dreamPriceGoal: 500000)
]

class AddDream {
    var dream: Dreams
    init(dream: Dreams) {
        self.dream = dream
    }
    func addNewDream(){
        dreams.append(dream)
    }
}
