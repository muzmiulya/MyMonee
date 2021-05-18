//
//  DreamTableViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamTableViewCell.self), for: indexPath) as! DreamTableViewCell
            // swiftlint:enable force_cast
            cell.dreamTitleLabel.text = dreams[indexPath.row].dreamTitle ?? ""
            cell.dreamPriceLabel.text = "IDR \(convertIntToCurrency(value:Balance().countBalance()))"
            cell.dreamPriceGoalLabel.text = "IDR \(convertIntToCurrency(value:dreams[indexPath.row].dreamPriceGoal ?? 0))"
            cell.dreamProgressView.progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
            return cell
        }
        else {
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamNotFoundTableViewCell.self), for: indexPath) as! DreamNotFoundTableViewCell
            cell.delegate = self
            // swiftlint:enable force_cast
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dreams.count > 0 {
            return 88.0
        }
        else {
            return 750.0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let viewController = DreamDetailViewController(nibName: String(describing: DreamDetailViewController.self), bundle: nil)
        viewController.titles = dreams[indexPath.row].dreamTitle ?? ""
        viewController.id = dreams[indexPath.row].id ?? ""
        viewController.progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
        viewController.money = Balance().countBalance()
        viewController.goal = dreams[indexPath.row].dreamPriceGoal ?? 0
        viewController.indexRow = indexPath.row
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = DreamAddViewController(nibName: String(describing: DreamAddViewController.self), bundle: nil)
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
extension DreamTableViewController: DreamEmpty {
    func addDream() {
        buttonAdd(self)
    }
}
