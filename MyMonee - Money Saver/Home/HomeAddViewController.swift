//
//  HomeAddViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class HomeAddViewController: UIViewController, UITextFieldDelegate {
    var utilization: Bool = true

    @IBOutlet weak var titleUsage: UITextField!
    @IBOutlet weak var usageAmount: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonViewOut: UIView!
    @IBOutlet weak var buttonSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        usageAmount.delegate = self
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOpacity = 0.15
        buttonView.layer.shadowOffset = .zero
        buttonView.layer.shadowRadius = 5
        buttonView.layer.cornerRadius = 10
        buttonViewOut.layer.shadowColor = UIColor.black.cgColor
        buttonViewOut.layer.shadowOpacity = 0.15
        buttonViewOut.layer.shadowOffset = .zero
        buttonViewOut.layer.shadowRadius = 5
        buttonViewOut.layer.cornerRadius = 10
        buttonSave.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_ :)))
        buttonView.addGestureRecognizer(tap)
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(tappedOut(_ :)))
        buttonViewOut.addGestureRecognizer(tapOut)
        buttonSave.isEnabled = false
    }
    @IBAction func buttonBack(_ sender: Any) {
        let viewController = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        buttonView.layer.borderWidth = 3
        buttonView.layer.borderColor = UIColor.blue.cgColor
        buttonViewOut.layer.borderWidth = 1
        buttonViewOut.layer.borderColor = UIColor.white.cgColor
        utilization = true
        buttonSave.isEnabled = true
        buttonSave.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        }
    @IBAction func tappedOut(_ gestureRecognizer: UITapGestureRecognizer) {
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonViewOut.layer.borderWidth = 3
        buttonViewOut.layer.borderColor = UIColor.blue.cgColor
        utilization = false
        buttonSave.isEnabled = true
        buttonSave.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        }
    @IBAction func addNewUsage(_ sender: Any) {
        let ids = "MM-\(randomString(length: 6))"
        let title = titleUsage.text ?? ""
        let amount = Int(usageAmount.text ?? "") ?? 0
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        let usage = UsageHistory(ids: ids, usageName: title, usagePrice: amount, usageDate: timestamp, status: utilization)
        Usage(usage: usage).addNewUsage()
        let viewController = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
}
