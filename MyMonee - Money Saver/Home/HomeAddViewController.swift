//
//  HomeAddViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

protocol UsageDelegate {
    func addUsage(usage: UsageHistory)
}
protocol HomeAdd {
    func buttonBack(_ sender: Any)
}
class HomeAddViewController: UIViewController, UITextFieldDelegate {
    var utilization: Bool = true
    var usageDelegate: UsageDelegate?

    @IBOutlet weak var titleUsage: UITextField!
    @IBOutlet weak var usageAmount: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonViewOut: UIView!
    @IBOutlet weak var buttonSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleUsage.delegate = self
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_ :)))
        buttonView.addGestureRecognizer(tap)
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(tappedOut(_ :)))
        buttonViewOut.addGestureRecognizer(tapOut)
        buttonSave.layer.cornerRadius = 10
        buttonSave.isEnabled = false
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
        if titleUsage.text?.isEmpty == true || usageAmount.text?.isEmpty == true {
            let alert = UIAlertController(title: "Judul dan Jumlah pemakaian harus diisi!",
                                           message: "",
                                           preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        } else {
            buttonSave.isEnabled = true
            let ids = "MM-\(randomString(length: 6))"
            let title = titleUsage.text ?? ""
            let amount = Int(usageAmount.text ?? "") ?? 0
//            let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
            let timestamp = Date()
            let usage = UsageHistory(ids: ids,
                                     usageName: title,
                                     usagePrice: amount,
                                     usageDate: timestamp,
                                     status: utilization)
            usageDelegate?.addUsage(usage: usage)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == usageAmount {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string))
            else {
                return false
            }
        }
        return true
    }
}
extension HomeAddViewController: HomeAdd {
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
