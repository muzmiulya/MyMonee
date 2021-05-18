//
//  Currency.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 18/05/21.
//

import Foundation

func convertIntToCurrency(value:Int) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "id_ID")
    formatter.groupingSeparator = "."
    formatter.numberStyle = .decimal
    var result: String = ""
    if let formattedTipAmount = formatter.string(from: value as NSNumber){
        result = formattedTipAmount
    }
    return result
}
