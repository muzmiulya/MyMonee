//
//  UsageHistoryDataSource.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 20/05/21.
//

import Foundation
import UIKit

class UsageHistoryDataSource: NSObject, UITableViewDataSource {
    
    var usageHistoryList: [UsageHistory] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self)) as! HomeTableViewCell
        cell.datas(select: usageHistoryList[indexPath.row])
        return cell
    }
}
