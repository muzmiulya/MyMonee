//
//  DreamDataSource.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 23/05/21.
//

import Foundation
import UIKit

class DreamDataSource: NSObject, UITableViewDataSource, Confirmation {
    var dreamList: [Dreams] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dreams.count > 0 {
            return dreamList.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dreams.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamTableViewCell.self)) as! DreamTableViewCell
            cell.delegateConfirm = self
            cell.dreamComplete.tag = indexPath.row
            cell.datas(select: dreamList[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamNotFoundTableViewCell.self), for: indexPath) as! DreamNotFoundTableViewCell
            return cell
        }
    }
    func dreamComplete(_ tag: Int) {
//        let alert = UIAlertController(title: "Selamat! \n Target impian anda telah tercapai! \n Ingin transaksi?", message: "", preferredStyle: UIAlertController.Style.alert)
//        let confirmAction = UIAlertAction(title: "Ya", style: UIAlertAction.Style.default) {_ in
//
//            }
//        alert.addAction(confirmAction)
//        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        let ids = dreams[tag].id ?? ""
        let title = dreams[tag].dreamTitle ?? ""
        let amount = dreams[tag].dreamPriceGoal ?? 0
        let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
        let usage = UsageHistory(ids: ids,
                                 usageName: title,
                                 usagePrice: amount,
                                 usageDate: timestamp,
                                 usageDateUpdated: timestamp,
                                 status: false)
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async {
            NetworkService().postMethod(usage: usage)
            group.leave()
        }
        group.enter()
        DispatchQueue.global(qos: .default).async {
            NetworkServiceDreams().deleteMethod(id: ids)
            group.leave()
        }
        group.wait()
        DreamTableViewController().loadData()
    }
    
    func dreamDelete(_ tag: Int) {
//        let alert = UIAlertController(title: "Apakah anda yakin ingin menghapus Impian?", message: "", preferredStyle: UIAlertController.Style.alert)
//        let deleteAction = UIAlertAction(title: "Hapus", style: UIAlertAction.Style.default) {_ in
//
//            }
//        alert.addAction(deleteAction)
//        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        let id = dreams[tag].id ?? ""
        NetworkServiceDreams().deleteMethod(id: id)
    }
}
