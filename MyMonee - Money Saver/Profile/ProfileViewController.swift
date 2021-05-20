//
//  ProfileViewController.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

protocol ProfilePage {
    func editAction(_ sender: Any)
    func doneAction(_ sender: Any)
    func editNameAction(_ sender: Any)
}

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editPictureButton: UIButton!
    @IBOutlet weak var editNameButton: UIButton!
    @IBAction func editPicture(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        doneButton.isHidden = true
        editPictureButton.isHidden = true
        editNameButton.isHidden = true
        self.profilePicture.contentMode = .scaleAspectFill
        self.profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        self.profilePicture.layer.masksToBounds = true
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                profilePicture.image = pickedImage
                profilePicture.contentMode = .scaleAspectFill
            }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
}
extension ProfileViewController: PassNameDelegate {
    func newName(name: String) {
        self.nameLabel.text = name
    }
}
extension ProfileViewController: ProfilePage {
    @IBAction func editAction(_ sender: Any) {
        editButton.isHidden = !editButton.isHidden
        editPictureButton.isHidden = false
        editNameButton.isHidden = false
    }
    @IBAction func doneAction(_ sender: Any) {
        doneButton.isHidden = !doneButton.isHidden
        editPictureButton.isHidden = true
        editNameButton.isHidden = true
    }
    @IBAction func editNameAction(_ sender: Any) {
        let popOverVC = PopUpViewController(nibName: String(describing: PopUpViewController.self), bundle: nil)
        popOverVC.passName = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
}
