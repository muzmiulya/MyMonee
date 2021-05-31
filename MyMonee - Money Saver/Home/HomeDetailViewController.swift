//
//  HomeDetailViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

protocol DetailHome {
    func backButton(_ sender: Any)
    func editButton(_ sender: Any)
}

class HomeDetailViewController: UIViewController {
    var ids: String = ""
    var indexRow: Int = 0
    @IBOutlet weak var viewHomeDetail: UIView!
    @IBOutlet weak var buttonBackDetail: UIButton!
    @IBOutlet weak var incomeOrOutcome: UIImageView!
    @IBOutlet weak var usageTitleLabel: UILabel!
    @IBOutlet weak var usageTypeLabel: UILabel!
    @IBOutlet weak var usagePriceLabel: UILabel!
    @IBOutlet weak var usageIdLabel: UILabel!
    @IBOutlet weak var usageDateLabel: UILabel!
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!
    var service: NetworkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHomeDetail.layer.cornerRadius = 25
        viewHomeDetail.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonBackDetail.layer.cornerRadius = 10
        buttonBackDetail.layer.borderWidth = 2
        buttonBackDetail.layer.borderColor = CGColor(red: 80/256,
                                                     green: 105/256,
                                                     blue: 184/256,
                                                     alpha: 1.0)
        self.loadDataBuId(id: ids)
    }
    func loadDataBuId(id: String) {
        detailActivityIndicator.isHidden = false
        detailActivityIndicator.startAnimating()
        service.loadGetById(id: id){(historyId) in
            DispatchQueue.main.async {[self] in
                usageObject = historyId!
                usageTitleLabel.text = usageObject.usageName
                usageIdLabel.text = usageObject.ids
                usageDateLabel.text = usageObject.usageDate
                if usageObject.status == true {
                    incomeOrOutcome.image = UIImage(named: "Arrow_Up")
                    usageTypeLabel.text = "Pemasukan"
                    usagePriceLabel.text = "+Rp \(usageObject.usagePrice?.convertIntToCurrency() ?? "")"
                    usagePriceLabel.textColor = UIColor(red: 33/256,
                                                             green: 150/256,
                                                             blue: 83/256,
                                                             alpha: 1.0)
                } else {
                    incomeOrOutcome.image = UIImage(named: "Arrow_Down")
                    usageTypeLabel.text = "Pengeluaran"
                    usagePriceLabel.text = "-Rp \(usageObject.usagePrice?.convertIntToCurrency() ?? "")"
                    usagePriceLabel.textColor = UIColor(red: 235/256,
                                                             green: 87/256,
                                                             blue: 87/256,
                                                             alpha: 1.0)
                }
                detailActivityIndicator.stopAnimating()
                detailActivityIndicator.isHidden = true
            }
        }
    }
}
extension HomeDetailViewController: DetailHome {
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let viewController = HomeEditViewController(nibName: String(describing: HomeEditViewController.self), bundle: nil)
        viewController.usageName = usageObject.usageName ?? ""
        viewController.indexRow = indexRow
        viewController.usagePrice = usageObject.usagePrice ?? 0
        viewController.usageDate = usageObject.usageDate ?? ""
        viewController.utilization = usageObject.status
        viewController.ids = ids
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
