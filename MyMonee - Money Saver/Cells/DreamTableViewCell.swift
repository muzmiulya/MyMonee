//
//  DreamTableViewCell.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

protocol Confirmation {
    func dreamComplete(_ tag: Int)
    func dreamDelete(_ tag: Int)
}

class DreamTableViewCell: UITableViewCell {
    var delegateConfirm: Confirmation?
    @IBOutlet weak var dreamMainView: UIView!
    @IBOutlet weak var dreamTitleLabel: UILabel!
    @IBOutlet weak var dreamPriceLabel: UILabel!
    @IBOutlet weak var dreamPriceGoalLabel: UILabel!
    @IBOutlet weak var dreamProgressView: UIProgressView!
    @IBOutlet weak var dreamComplete: UIButton!
    @IBOutlet weak var deleteDream: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        dreamMainView.layer.cornerRadius = 5
        self.selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func datas(select: Dreams) {
        dreamTitleLabel.text = select.dreamTitle ?? ""
        dreamPriceLabel.text = "IDR \(Balance().countBalance().convertIntToCurrency())"
        dreamPriceGoalLabel.text = "IDR \(select.dreamPriceGoal?.convertIntToCurrency() ?? "")"
        let progress = Float(Balance().countBalance()) / Float(select.dreamPriceGoal ?? 0)
        dreamProgressView.progress = progress
        dreamComplete.isEnabled = false
        if progress >= 1 {
            dreamComplete.isEnabled = true
            dreamComplete.setImage(UIImage(named: "Check_Selected"), for: .normal)
        } else {
            dreamComplete.isEnabled = false
            dreamComplete.setImage(UIImage(named: "Check"), for: .normal)
        }
    }
    
    @IBAction func achieveDream(_ sender: UIButton) {
        self.delegateConfirm?.dreamComplete(sender.tag)
    }
    @IBAction func deleteDreamAction(_ sender: UIButton) {
        self.delegateConfirm?.dreamDelete(sender.tag)
    }
}
