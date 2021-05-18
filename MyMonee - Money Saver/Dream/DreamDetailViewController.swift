//
//  DreamDetailViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class DreamDetailViewController: UIViewController {
    var titles: String = ""
    var id: String = ""
    var goal: Int = 0
    var progress: Float = 0.0
    var money: Int = 0
    var indexRow: Int = 0
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dreamTitle: UILabel!
    @IBOutlet weak var dreamPrice: UILabel!
    @IBOutlet weak var dreamPercentage: UILabel!
    @IBOutlet weak var dreamProgress: UIProgressView!
    @IBOutlet weak var dreamMoney: UILabel!
    @IBOutlet weak var dreamGoal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.layer.shadowColor = UIColor.black.cgColor
        progressView.layer.shadowOpacity = 0.15
        progressView.layer.shadowOffset = .zero
        progressView.layer.shadowRadius = 5
        progressView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        self.dreamTitle.text = titles
        self.dreamPrice.text = "Rp \(convertIntToCurrency(value:goal))"
        self.dreamProgress.progress = progress
        self.dreamPercentage.text = "\(String(format: "%.2f", progress*100))%"
        self.dreamMoney.text = "IDR \(convertIntToCurrency(value:money))"
        self.dreamGoal.text = "IDR \(convertIntToCurrency(value:goal))"
        print(progress)
        if progress >= 1.0 {
            confirmButton.isEnabled = true
            confirmButton.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        } else {
            confirmButton.isEnabled = false
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let viewController = DreamEditViewController(nibName: String(describing: DreamEditViewController.self), bundle: nil)
        viewController.titles = titles
        viewController.priceGoal = goal
        viewController.indexRow = indexRow
//        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func dreamReachedButton(_ sender: Any) {
        let alert = UIAlertController (title: "Selamat! \n Target impian anda telah tercapai! \n Apakah sudah melakukan transaksi?", message: "", preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Ya", style: UIAlertAction.Style.default) {_ in
            let ids = "MM-\(self.randomString(length: 6))"
            let title = self.titles
            let amount = self.goal
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            let usage = UsageHistory(ids: ids, usageName: title, usagePrice: amount, usageDate: timestamp, status: false)
            Usage(usage: usage).addNewUsage()
            dreams.remove(at: self.indexRow)
            self.navigationController?.popToRootViewController(animated: true)
            }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
}
