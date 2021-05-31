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
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var dreamService: NetworkServiceDreams = NetworkServiceDreams()
    var dataSource: DreamDataSource = DreamDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        let uinib = UINib(nibName: String(describing: DreamNotFoundTableViewCell.self), bundle: nil)
        dreamTableView.register(uinib, forCellReuseIdentifier: String(describing: DreamNotFoundTableViewCell.self))
        let uiNib = UINib(nibName: String(describing: DreamTableViewCell.self), bundle: nil)
        dreamTableView.register(uiNib, forCellReuseIdentifier: String(describing: DreamTableViewCell.self))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.toast(_:)),
                                               name: Notification.Name("EditDream"),
                                               object: nil)
        self.tableView.dataSource = self.dataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    func loadData() {
        activityIndicator.startAnimating()
        activityIndicatorView.isHidden = false
        self.dreamService.dreamList { (lists) in
            DispatchQueue.main.async {
                dreams = lists
                self.dataSource.dreamList = lists
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
    @objc func toast(_ notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            let text = dict["text"] as? String
            let seconds = dict["seconds"] as? Double
            showToast(message: text ?? "", seconds: seconds ?? 0.0)
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
        let viewController = DreamDetailViewController(nibName: String(describing: DreamDetailViewController.self), bundle: nil)
        viewController.id = dreams[indexPath.row].id ?? ""
        viewController.indexRow = indexPath.row
        viewController.delegateToast = self
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
extension DreamTableViewController: DreamEmpty {
    func addDream() {
        buttonAdd(self)
    }
}
extension DreamTableViewController: AddToastDream, DetailToastDream {
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
extension DreamTableViewController: DreamPage {
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = DreamAddViewController(nibName: String(describing: DreamAddViewController.self), bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        viewController.delegateToast = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
//    func dreamComplete(_ tag: Int) {
//        let alert = UIAlertController(title: "Selamat! \n Target impian anda telah tercapai! \n Ingin transaksi?", message: "", preferredStyle: UIAlertController.Style.alert)
//        let confirmAction = UIAlertAction(title: "Ya", style: UIAlertAction.Style.default) {_ in
//            let ids = dreams[tag].id ?? ""
//            let title = dreams[tag].dreamTitle ?? ""
//            let amount = dreams[tag].dreamPriceGoal ?? 0
//            let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
//            let usage = UsageHistory(ids: ids,
//                                     usageName: title,
//                                     usagePrice: amount,
//                                     usageDate: timestamp,
//                                     usageDateUpdated: timestamp,
//                                     status: false)
//            NetworkService().postMethod(usage: usage)
//            NetworkServiceDreams().deleteMethod(id: ids)
//            self.tableView.reloadData()
//            }
//        alert.addAction(confirmAction)
//        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)
//    }
//    func dreamDelete(_ tag: Int) {
//        let alert = UIAlertController(title: "Apakah anda yakin ingin menghapus Impian?", message: "", preferredStyle: UIAlertController.Style.alert)
//        let deleteAction = UIAlertAction(title: "Hapus", style: UIAlertAction.Style.default) {_ in
//            let ids = dreams[tag].id ?? ""
//            NetworkServiceDreams().deleteMethod(id: ids)
//            self.tableView.reloadData()
//            }
//        alert.addAction(deleteAction)
//        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
}
