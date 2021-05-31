//
//  HomeViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

protocol HomePage {
    func buttonAdd(_ sender: Any)
}

class HomeViewController: UIViewController,
                          UICollectionViewDataSource {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usageHistoryView: UIView!
    @IBOutlet weak var totalCashView: UIView!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var notFoundView: HomeDataNotFound!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    var dataSource: UsageHistoryDataSource = UsageHistoryDataSource()
    var service: NetworkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        let uiNib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        let uINib = UINib(nibName: String(describing: HomeCollectionViewCell.self), bundle: nil)
        collectionView.register(uINib, forCellWithReuseIdentifier: String(describing: HomeCollectionViewCell.self))
        usageHistoryView.layer.cornerRadius = 25
        usageHistoryView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        totalCashView.layer.cornerRadius = 10
        notFoundView.delegate = self
        notFoundView.layer.cornerRadius = 25
        notFoundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.changeName(_:)),
                                               name: Notification.Name("changeName"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.toast(_:)),
                                               name: Notification.Name("Edited"),
                                               object: nil)
        self.tableView.dataSource = self.dataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
        showTime()
        tableView.reloadData()
        latest()
        collectionView.reloadData()
    }
    func loadData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        self.service.usageList { (lists) in
            DispatchQueue.main.async {
                usageHistory = lists
                self.dataSource.usageHistoryList = lists
                self.tableView.reloadData()
                self.totalBalanceLabel.text = "Rp \(Balance().countBalance().convertIntToCurrency())"
                self.latest()
                self.collectionView.reloadData()
                if usageHistory.count > 0 {
                    self.notFoundView.isHidden = true
                } else {
                    self.notFoundView.isHidden = false
                }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    @objc func changeName(_ notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let names = dict["name"] as? String {
                self.yourNameLabel.text = names
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
    func latest() {
        CountSpending().latestUsageCount(transaction: .income)
        CountSpending().latestUsageCount(transaction: .outcome)
    }
    func showTime() {
        let dateNow = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: dateNow)
        if hour >= 06 && hour < 11 {
            timeLabel.text = "Selamat Pagi"
        } else if hour >= 11 && hour < 15 {
            timeLabel.text = "Selamat Siang"
        } else if hour >= 15 && hour < 18 {
            timeLabel.text = "Selamat Sore"
        } else if hour >= 18 && hour <= 24 {
            timeLabel.text = "Selamat Malam"
        } else {
            timeLabel.text = "Selamat Malam"
        }
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = HomeDetailViewController(nibName: String(describing: HomeDetailViewController.self), bundle: nil)
        viewController.ids = usageHistory[indexPath.row].ids ?? ""
        viewController.indexRow = indexPath.row
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestUsage.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCollectionViewCell.self), for: indexPath) as! HomeCollectionViewCell
        // swiftlint:enable force_cast
        cell.activityLabel.text = latestUsage[indexPath.row].usageName ?? ""
        cell.latestPriceLabel.text = "Rp \(latestUsage[indexPath.row].usagePrice?.convertIntToCurrency() ?? "")"
        if latestUsage[indexPath.row].status ?? true {
            cell.arrowDirection.image = UIImage(named: "Arrow_Up_Single")
        } else {
            cell.arrowDirection.image = UIImage(named: "Arrow_Down_Single")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - (10), height: 47)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
}
extension HomeViewController: HomePage {
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = HomeAddViewController(nibName: String(describing: HomeAddViewController.self), bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        viewController.delegateToast = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
extension HomeViewController: EmptyData {
    func add() {
        let viewController = HomeAddViewController(nibName: String(describing: HomeAddViewController.self), bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        viewController.delegateToast = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
extension HomeViewController: AddToast {
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
extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
extension Int {
    func convertIntToCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        var result: String = ""
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            result = formattedTipAmount
        }
        return result
    }
}

