//
//  PopUpViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 16/05/21.
//

import UIKit

protocol PassNameDelegate {
    func newName(name: String)
}

class PopUpViewController: UIViewController {
    var passName: PassNameDelegate!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var popUpTextField: UITextField!
    @IBOutlet weak var popUpSaveButton: UIButton!
    @IBOutlet weak var popUpCancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.mainView.layer.cornerRadius = 10
        self.popUpSaveButton.layer.cornerRadius = 10
        self.showAnimate()
    }
    @IBAction func closePopUpButton(_ sender: Any) {
        let popOverVC = PopUpViewController(nibName: String(describing: PopUpViewController.self), bundle: nil)
        popOverVC.willMove(toParent: nil)
        popOverVC.view.removeFromSuperview()
        popOverVC.removeFromParent()
        self.removeAnimate()
    }
    @IBAction func savePopUpButton(_ sender: Any) {
        let nameText = popUpTextField.text ?? "Your Name"
        passName.newName(name: nameText)
        let popOverVC = PopUpViewController(nibName: String(describing: PopUpViewController.self), bundle: nil)
        NotificationCenter.default.post(name: Notification.Name("changeName"), object: nil, userInfo: ["name": nameText])
        popOverVC.willMove(toParent: nil)
        popOverVC.view.removeFromSuperview()
        popOverVC.removeFromParent()
        self.removeAnimate()
    }
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {
            (finished : Bool) in
            if finished {
                self.view.removeFromSuperview()
            }
        })
    }
}
