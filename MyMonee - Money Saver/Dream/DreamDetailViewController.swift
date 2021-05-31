//
//  DreamDetailViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

protocol DetailToastDream {
    func showToast(message : String, seconds: Double)
}

protocol DetailDream {
    func backButton(_ sender: Any)
    func editButton(_ sender: Any)
    func dreamReachedButton(_ sender: Any)
}

class DreamDetailViewController: UIViewController {
    var id: String = ""
    var indexRow: Int = 0
    @IBOutlet weak var dreamDetailView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dreamTitle: UILabel!
    @IBOutlet weak var dreamPrice: UILabel!
    @IBOutlet weak var dreamPercentage: UILabel!
    @IBOutlet weak var dreamProgress: UIProgressView!
    @IBOutlet weak var dreamMoney: UILabel!
    @IBOutlet weak var dreamGoal: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var service: NetworkServiceDreams = NetworkServiceDreams()
    var delegateToast: DetailToastDream?
    override func viewDidLoad() {
        super.viewDidLoad()
        dreamDetailView.layer.cornerRadius = 25
        dreamDetailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        progressView.layer.shadowColor = UIColor.black.cgColor
        progressView.layer.shadowOpacity = 0.15
        progressView.layer.shadowOffset = .zero
        progressView.layer.shadowRadius = 5
        progressView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        self.loadDataById(id: id)
    }
    func loadDataById(id: String) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        service.dreamListById(id: id){(dreamId) in
            DispatchQueue.main.async {[self] in
                dreamObject = dreamId!
                dreamTitle.text = dreamId?.dreamTitle
                dreamPrice.text = "Rp \(dreamId?.dreamPriceGoal?.convertIntToCurrency() ?? "")"
                let progress = Float(Balance().countBalance()) / Float(dreamId?.dreamPriceGoal ?? 0)
                dreamProgress.progress = progress
                dreamPercentage.text = "\(String(format: "%.2f", progress*100))%"
                dreamMoney.text = "IDR \(Balance().countBalance().convertIntToCurrency())"
                dreamGoal.text = "IDR \(dreamId?.dreamPriceGoal?.convertIntToCurrency() ?? ""))"
                if progress >= 1.0 {
                    confirmButton.isEnabled = true
                    confirmButton.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
                } else {
                    confirmButton.isEnabled = false
                }
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
}
extension DreamDetailViewController: DetailDream {
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let viewController = DreamEditViewController(nibName: String(describing: DreamEditViewController.self), bundle: nil)
        viewController.id = id
        viewController.titles = dreamObject.dreamTitle ?? ""
        viewController.priceGoal = dreamObject.dreamPriceGoal ?? 0
        viewController.indexRow = indexRow
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func dreamReachedButton(_ sender: Any) {
        let alert = UIAlertController(title: "Selamat! \n Target impian anda telah tercapai! \n Ingin transaksi?",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Ya", style: UIAlertAction.Style.default) {_ in
            let ids = "MM-\(self.randomString(length: 6))"
            let title = dreamObject.dreamTitle
            let amount = dreamObject.dreamPriceGoal
            let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
            let usage = UsageHistory(ids: ids,
                                     usageName: title ?? "",
                                     usagePrice: amount ?? 0,
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
                NetworkServiceDreams().deleteMethod(id: self.id)
                group.leave()
            }
            group.wait()
            self.navigationController?.popToRootViewController(animated: true)
            self.delegateToast?.showToast(message: "Dream Completed!", seconds: 1.5)
        }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
