//
//  DreamAddViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class DreamAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dreamTitle: UITextField!
    @IBOutlet weak var dreamGoal: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dreamGoal.delegate = self
        buttonSave.layer.cornerRadius = 10
//        setupAddTargetIsNotEmptyTextFields()
//        self.buttonSave.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
    }
//        func setupAddTargetIsNotEmptyTextFields() {
//            buttonSave.isEnabled = false
//            dreamTitle.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                        for: .editingChanged)
//            dreamGoal.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                        for: .editingChanged)
//           }
//        @objc func textFieldsIsNotEmpty(sender: UITextField) {
//            sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
//            guard
//              let name = dreamTitle.text, !name.isEmpty,
//              let email = dreamGoal.text, !email.isEmpty
//              else
//            {
//                self.buttonSave.isEnabled = false
//                return
//            }
//            buttonSave.isEnabled = true
//            buttonSave.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
//        }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func addDreamButton(_ sender: Any) {
        let ids = "DD-\(randomString(length: 6))"
        let title = dreamTitle.text ?? ""
        let priceGoal = Int(dreamGoal.text ?? "") ?? 0
        let inputDream = Dreams(id: ids, dreamTitle: title, dreamPriceGoal: priceGoal)
        AddDream(dream: inputDream).addNewDream()
        self.navigationController?.popToRootViewController(animated: true)
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
