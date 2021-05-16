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
    }
    @IBAction func buttonBack(_ sender: Any) {
        let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func addDreamButton(_ sender: Any) {
        let ids = "DD-\(randomString(length: 6))"
        let title = dreamTitle.text ?? ""
        let priceGoal = Int(dreamGoal.text ?? "") ?? 0
        let inputDream = Dreams(id: ids, dreamTitle: title, dreamPriceGoal: priceGoal)
        AddDream(dream: inputDream).addNewDream()
        let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
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
