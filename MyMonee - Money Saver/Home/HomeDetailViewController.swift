//
//  HomeDetailViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class HomeDetailViewController: UIViewController {
    var usageName: String = ""
    var typeLabel: String = ""
    var usagePrice: Int = 0
    var ids: String = ""
    var usageDate: String = ""
    var status: Bool = true
    var indexRow: Int = 0
    @IBOutlet weak var viewHomeDetail: UIView!
    @IBOutlet weak var buttonBackDetail: UIButton!
    @IBOutlet weak var incomeOrOutcome: UIImageView!
    @IBOutlet weak var usageTitleLabel: UILabel!
    @IBOutlet weak var usageTypeLabel: UILabel!
    @IBOutlet weak var usagePriceLabel: UILabel!
    @IBOutlet weak var usageIdLabel: UILabel!
    @IBOutlet weak var usageDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHomeDetail.layer.cornerRadius = 25
        buttonBackDetail.layer.cornerRadius = 10
        buttonBackDetail.layer.borderWidth = 2
        buttonBackDetail.layer.borderColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        self.usageTitleLabel.text = usageName
        self.usageIdLabel.text = ids
        self.usageDateLabel.text = usageDate
        if status == true {
            self.incomeOrOutcome.image = UIImage(named: "Arrow_Up")
            self.usageTypeLabel.text = "Pemasukan"
            self.usagePriceLabel.text = "+Rp \(convertIntToCurrency(value:usagePrice))"
            self.usagePriceLabel.textColor = UIColor(red: 33/256, green: 150/256, blue: 83/256, alpha: 1.0)
        } else {
            self.incomeOrOutcome.image = UIImage(named: "Arrow_Down")
            self.usageTypeLabel.text = "Pengeluaran"
            self.usagePriceLabel.text = "-Rp \(convertIntToCurrency(value:usagePrice))"
            self.usagePriceLabel.textColor = UIColor(red: 235/256, green: 87/256, blue: 87/256, alpha: 1.0)
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let viewController = HomeEditViewController(nibName: String(describing: HomeEditViewController.self), bundle: nil)
        viewController.usageName = usageName
        viewController.indexRow = indexRow
        viewController.usagePrice = usagePrice
        viewController.utilization = status
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
