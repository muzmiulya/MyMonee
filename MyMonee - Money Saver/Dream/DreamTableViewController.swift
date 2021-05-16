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
        let uiNib = UINib(nibName: String(describing: DreamTableViewCell.self), bundle: nil)
        dreamTableView.register(uiNib, forCellReuseIdentifier: String(describing: DreamTableViewCell.self))
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dreams.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamTableViewCell.self), for: indexPath) as! DreamTableViewCell
        // swiftlint:enable force_cast
        cell.dreamTitleLabel.text = dreams[indexPath.row].dreamTitle ?? ""
        cell.dreamPriceLabel.text = "\(Balance().countBalance())"
        cell.dreamPriceGoalLabel.text = "IDR \(dreams[indexPath.row].dreamPriceGoal ?? 0)"
        cell.dreamProgressView.progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let viewController = DreamDetailViewController(nibName: String(describing: DreamDetailViewController.self), bundle: nil)
        viewController.titles = dreams[indexPath.row].dreamTitle ?? ""
        viewController.id = dreams[indexPath.row].id ?? ""
        viewController.progress = Float(Balance().countBalance()) / Float(dreams[indexPath.row].dreamPriceGoal ?? 0)
        viewController.money = Balance().countBalance()
        viewController.goal = dreams[indexPath.row].dreamPriceGoal ?? 0
        viewController.indexRow = indexPath.row
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = DreamAddViewController(nibName: String(describing: DreamAddViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
