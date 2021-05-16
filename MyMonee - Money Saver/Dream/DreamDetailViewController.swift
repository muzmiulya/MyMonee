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
        self.dreamPrice.text = "Rp \(goal)"
        self.dreamProgress.progress = progress
        self.dreamPercentage.text = "\(String(format: "%.2f", progress*100))%"
        self.dreamMoney.text = "IDR \(money)"
        self.dreamGoal.text = "IDR \(goal)"
        print(progress)
        if progress >= 1.0 {
            confirmButton.isEnabled = true
            confirmButton.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        } else {
            confirmButton.isEnabled = false
        }
    }

    @IBAction func backButton(_ sender: Any) {
        let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let viewController = DreamEditViewController(nibName: String(describing: DreamEditViewController.self), bundle: nil)
        viewController.titles = titles
        viewController.priceGoal = goal
        viewController.indexRow = indexRow
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func dreamReachedButton(_ sender: Any) {
        dreams.remove(at: self.indexRow)
        let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
