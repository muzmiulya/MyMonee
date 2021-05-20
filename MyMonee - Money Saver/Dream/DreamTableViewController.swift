//
//  DreamTableViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

protocol DreamPage {
    func buttonAdd(_ sender: Any)
}

class DreamTableViewController: UITableViewController {
    @IBOutlet weak var dreamTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let uinib = UINib(nibName: String(describing: DreamNotFoundTableViewCell.self), bundle: nil)
        dreamTableView.register(uinib, forCellReuseIdentifier: String(describing: DreamNotFoundTableViewCell.self))
        let uiNib = UINib(nibName: String(describing: DreamTableViewCell.self), bundle: nil)
        dreamTableView.register(uiNib, forCellReuseIdentifier: String(describing: DreamTableViewCell.self))
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dreams.count > 0 {
            return dreams.count
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dreams.count > 0 {
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamTableViewCell.self),
                for: indexPath) as! DreamTableViewCell
            // swiftlint:enable force_cast
            cell.delegateConfirm = self
            cell.dreamComplete.tag = indexPath.row
            cell.dreamTitleLabel.text = dreams[indexPath.row].dreamTitle ?? ""
            cell.dreamPriceLabel.text = "IDR \(convertIntToCurrency(value: Balance().countBalance()))"
            cell.dreamPriceGoalLabel.text = "IDR \(convertIntToCurrency(value: dreams[indexPath.row].dreamPriceGoal ?? 0))"
            let progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
            cell.dreamProgressView.progress = progress
            cell.dreamComplete.isEnabled = false
            if progress >= 1 {
                cell.dreamComplete.isEnabled = true
                cell.dreamComplete.setImage(UIImage(named: "Check_Selected"), for: .normal)
            } else {
                cell.dreamComplete.isEnabled = false
                cell.dreamComplete.setImage(UIImage(named: "Check"), for: .normal)
            }
            return cell
        } else {
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamNotFoundTableViewCell.self),
                for: indexPath) as! DreamNotFoundTableViewCell
            cell.delegate = self
            // swiftlint:enable force_cast
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dreams.count > 0 {
            return 88.0
        } else {
            return 750.0
        }
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let viewController = DreamDetailViewController(nibName: String(describing: DreamDetailViewController.self),
                                                       bundle: nil)
        viewController.titles = dreams[indexPath.row].dreamTitle ?? ""
        viewController.id = dreams[indexPath.row].id ?? ""
        viewController.progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
        viewController.money = Balance().countBalance()
        viewController.goal = dreams[indexPath.row].dreamPriceGoal ?? 0
        viewController.indexRow = indexPath.row
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
}
extension DreamTableViewController: DreamEmpty {
    func addDream() {
        buttonAdd(self)
    }
}
extension DreamTableViewController: DreamDelegate {
    func addDream(dream: Dreams) {
        dreams.append(dream)
    }
}
extension DreamTableViewController: DreamPage, Confirmation {
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = DreamAddViewController(nibName: String(describing: DreamAddViewController.self),
                                                    bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        viewController.dreamDelegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func dreamComplete(_ tag: Int) {
        let alert = UIAlertController(title: "Selamat! \n Target impian anda telah tercapai! \n Ingin transaksi?",
                                       message: "",
                                       preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Ya", style: UIAlertAction.Style.default) {_ in
            let ids = "MM-\(self.randomString(length: 6))"
            let title = dreams[tag].dreamTitle ?? ""
            let amount = dreams[tag].dreamPriceGoal ?? 0
//            let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
            let timestamp = Date()
            let usage = UsageHistory(ids: ids,
                                     usageName: title,
                                     usagePrice: amount,
                                     usageDate: timestamp,
                                     status: false)
            Usage(usage: usage).addNewUsage()
            dreams.remove(at: tag)
            self.tableView.reloadData()
            }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func dreamDelete(_ tag: Int) {
        let alert = UIAlertController(title: "Apakah anda yakin ingin menghapus Impian?",
                                       message: "",
                                       preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Hapus", style: UIAlertAction.Style.default) {_ in
            dreams.remove(at: tag)
            self.tableView.reloadData()
            }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
