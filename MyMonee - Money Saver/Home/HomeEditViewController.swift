//
//  HomeEditViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

protocol EditHome {
    func backButton(_ sender: Any)
    func editButton(_ sender: Any)
    func deleteButton(_ sender: Any)
}

class HomeEditViewController: UIViewController, UITextFieldDelegate {
    var usageName: String = ""
    var usagePrice: Int = 0
    var indexRow: Int = 0
    var utilization: Bool = true

    @IBOutlet weak var titleEdit: UITextField!
    @IBOutlet weak var amountEdit: UITextField!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonViewOut: UIView!
    @IBOutlet weak var buttonRenew: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleEdit.delegate = self
        amountEdit.delegate = self
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
        buttonRenew.layer.cornerRadius = 10
        buttonDelete.layer.cornerRadius = 10
        buttonDelete.layer.borderWidth = 3
        buttonDelete.layer.borderColor = CGColor(red: 235/256, green: 87/256, blue: 87/256, alpha: 1.0)
        titleEdit.text = usageName
        amountEdit.text = "\(usagePrice)"
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_ :)))
        buttonView.addGestureRecognizer(tap)
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(tappedOut(_ :)))
        buttonViewOut.addGestureRecognizer(tapOut)
        if utilization == true {
            self.tapped(tap)
        } else {
            self.tappedOut(tapOut)
        }
    }   
    @IBAction func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        buttonView.layer.borderWidth = 3
        buttonView.layer.borderColor = UIColor.blue.cgColor
        buttonViewOut.layer.borderWidth = 1
        buttonViewOut.layer.borderColor = UIColor.white.cgColor
        utilization = true
        buttonRenew.isEnabled = true
        buttonRenew.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        }
    @IBAction func tappedOut(_ gestureRecognizer: UITapGestureRecognizer) {
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.white.cgColor
        buttonViewOut.layer.borderWidth = 3
        buttonViewOut.layer.borderColor = UIColor.blue.cgColor
        utilization = false
        buttonRenew.isEnabled = true
        buttonRenew.layer.backgroundColor = CGColor(red: 80/256, green: 105/256, blue: 184/256, alpha: 1.0)
        }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == amountEdit {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string))
            else {
                return false
            }
        }
        return true
    }
}
extension HomeEditViewController: EditHome {
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        if titleEdit.text?.isEmpty == true || amountEdit.text?.isEmpty == true {
            let alert = UIAlertController(title: "Judul dan Jumlah pemakaian harus diisi!",
                                           message: "",
                                           preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        } else {
            let title = titleEdit.text ?? ""
            let amount = Int(amountEdit.text ?? "") ?? 0
//            let timestamp = Date().toString(format: "dd MMMM yyyy - hh:mm")
            let timestamp = Date()
            usageHistory[indexRow].usageName = title
            usageHistory[indexRow].usagePrice = amount
            usageHistory[indexRow].usageDate = timestamp
            usageHistory[indexRow].status = utilization
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Apakah anda yakin ingin menghapus Riwayat Penggunaan?",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Hapus", style: UIAlertAction.Style.default) {_ in
            usageHistory.remove(at: self.indexRow)
            self.navigationController?.popToRootViewController(animated: true)
            }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
