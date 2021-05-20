//
//  DreamNotFoundTableViewCell.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 17/05/21.
//

import UIKit

protocol DreamEmpty {
    func addDream()
}
protocol DreamNotFound {
    func buttonAction(_ sender: Any)
}

class DreamNotFoundTableViewCell: UITableViewCell, DreamNotFound {
    var delegate: DreamEmpty?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buttonAdd: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonAdd.layer.cornerRadius = 20
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.addDream()
    }
}
