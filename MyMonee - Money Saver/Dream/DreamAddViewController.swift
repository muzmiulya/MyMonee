//
//  DreamAddViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

protocol AddToastDream {
    func showToast(message : String, seconds: Double)
}
protocol DreamAdd {
    func buttonBack(_ sender: Any)
}

class DreamAddViewController: UIViewController, UITextFieldDelegate {
    var delegateToast: AddToastDream?
    @IBOutlet weak var dreamTitle: UITextField!
    @IBOutlet weak var dreamGoal: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dreamTitle.delegate = self
        dreamGoal.delegate = self
        buttonSave.layer.cornerRadius = 10
        buttonSave.isEnabled = false
        buttonSave.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
    }
    @IBAction func addDreamButton(_ sender: Any) {
        let ids = "DD-\(randomString(length: 6))"
        let title = dreamTitle.text ?? ""
        let priceGoal = Int(dreamGoal.text ?? "") ?? 0
        let inputDream = Dreams(id: ids, dreamTitle: title, dreamPriceGoal: priceGoal)
        NetworkServiceDreams().postMethod(dream: inputDream)
        self.navigationController?.popToRootViewController(animated: true)
        delegateToast?.showToast(message: "Dream Succesfully Added!", seconds: 1.5)
    }
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == dreamGoal {
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string))
            else {
                return false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now () + 0.01) {
            if self.dreamTitle.text?.isEmpty ?? true || self.dreamGoal.text?.isEmpty ?? true {
                self.buttonSave.isEnabled = false
                self.buttonSave.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            } else {
                self.buttonSave.isEnabled = true
                self.buttonSave.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1)
            }
        }
        return true
    }
}
extension DreamAddViewController: DreamAdd {
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
