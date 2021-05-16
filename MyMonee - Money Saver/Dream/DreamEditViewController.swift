//
//  DreamEditViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class DreamEditViewController: UIViewController, UITextFieldDelegate {
    var titles: String = ""
    var priceGoal: Int = 0
    var indexRow: Int = 0

    @IBOutlet weak var titleEdit: UITextField!
    @IBOutlet weak var priceGoalEdit: UITextField!
    @IBOutlet weak var renewDreamButton: UIButton!
    @IBOutlet weak var eraseDreamButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        priceGoalEdit.delegate = self
        renewDreamButton.layer.cornerRadius = 10
        eraseDreamButton.layer.cornerRadius = 10
        eraseDreamButton.layer.borderWidth = 3
        eraseDreamButton.layer.borderColor = CGColor(red: 235/256, green: 87/256, blue: 87/256, alpha: 1.0)
        titleEdit.text = titles
        priceGoalEdit.text = "\(priceGoal)"
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    @IBAction func editButton(_ sender: Any) {
        let title = titleEdit.text ?? ""
        let priceGoal = Int(priceGoalEdit.text ?? "") ?? 0
        dreams[indexRow].dreamTitle = title
        dreams[indexRow].dreamPriceGoal = priceGoal
        let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController (title: "Apakah anda yakin ingin menghapus Impian?", message: "", preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Hapus", style: UIAlertAction.Style.default) {_ in
            dreams.remove(at: self.indexRow)
            let viewController = DreamTableViewController(nibName: String(describing: DreamTableViewController.self), bundle: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
            }
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Batal", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
