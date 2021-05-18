//
//  HomeViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var usageHistoryView: UIView!
    @IBOutlet weak var totalCashView: UIView!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var notFoundView: HomeDataNotFound!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        let uiNib = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        let uINib = UINib(nibName: String(describing: HomeCollectionViewCell.self), bundle: nil)
        collectionView.register(uINib, forCellWithReuseIdentifier: String(describing: HomeCollectionViewCell.self))
        usageHistoryView.layer.cornerRadius = 25
        totalCashView.layer.cornerRadius = 10
        notFoundView.delegate = self
        notFoundView.layer.cornerRadius = 25
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeName(_:)), name: Notification.Name("changeName"), object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        if usageHistory.count > 0 {
            notFoundView.isHidden = true
        } else {
            notFoundView.isHidden = false
        }
        super.viewDidAppear(animated)
        totalBalanceLabel.text = "Rp \(convertIntToCurrency(value: Balance().countBalance()))"
        showTime()
        tableView.reloadData()
        latest()
        collectionView.reloadData()
    }
    @IBAction func buttonAdd(_ sender: Any) {
        let viewController = HomeAddViewController(nibName: String(describing: HomeAddViewController.self), bundle: nil)
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func changeName(_ notification: Notification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let names = dict["name"] as? String {
                self.yourNameLabel.text = names
            }
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
        }
        else if hour >= 11 && hour < 15 {
            timeLabel.text = "Selamat Siang"
        }
        else if hour >= 16 && hour < 18 {
            timeLabel.text = "Selamat Sore"
        }
        else if hour >= 18 && hour <= 24 {
            timeLabel.text = "Selamat Malam"
        }
        else {
            timeLabel.text = "Selamat Malam"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self), for: indexPath) as! HomeTableViewCell
        // swiftlint:enable force_cast
        cell.titleLabel.text = usageHistory[indexPath.row].usageName ?? ""
        cell.dateLabel.text = usageHistory[indexPath.row].usageDate ?? ""
        if usageHistory[indexPath.row].status ?? true {
            cell.imageStatus.image = UIImage(named: "Arrow_Up")
            cell.priceLabel.text = "+Rp \(convertIntToCurrency(value:usageHistory[indexPath.row].usagePrice ?? 0))"
            cell.priceLabel.textColor = UIColor(red: 33/256, green: 150/256, blue: 83/256, alpha: 1.0)
        } else {
            cell.imageStatus.image = UIImage(named: "Arrow_Down")
            cell.priceLabel.text = "-Rp \(convertIntToCurrency(value:usageHistory[indexPath.row].usagePrice ?? 0))"
            cell.priceLabel.textColor = UIColor(red: 235/256, green: 87/256, blue: 87/256, alpha: 1.0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = HomeDetailViewController(nibName: String(describing: HomeDetailViewController.self), bundle: nil)
        viewController.usageName = usageHistory[indexPath.row].usageName ?? ""
        viewController.ids = usageHistory[indexPath.row].ids ?? ""
        viewController.usageDate = usageHistory[indexPath.row].usageDate ?? ""
        viewController.usagePrice = usageHistory[indexPath.row].usagePrice ?? 0
        viewController.status = usageHistory[indexPath.row].status ?? true
        viewController.indexRow = indexPath.row
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestUsage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCollectionViewCell.self), for: indexPath) as! HomeCollectionViewCell
        // swiftlint:enable force_cast
        cell.activityLabel.text = latestUsage[indexPath.row].usageName ?? ""
        cell.latestPriceLabel.text = "Rp \(convertIntToCurrency(value:latestUsage[indexPath.row].usagePrice ?? 0))"
        if latestUsage[indexPath.row].status ?? true {
            cell.arrowDirection.image = UIImage(named: "Arrow_Up_Single")
        } else {
            cell.arrowDirection.image = UIImage(named: "Arrow_Down_Single")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - (10), height: 47)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
}
extension HomeViewController: EmptyData {
    func add() {
        let viewController = HomeAddViewController(nibName: String(describing: HomeAddViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
