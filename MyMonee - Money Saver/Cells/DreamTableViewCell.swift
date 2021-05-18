//
//  DreamTableViewCell.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class DreamTableViewCell: UITableViewCell {

    @IBOutlet weak var dreamMainView: UIView!
    @IBOutlet weak var dreamTitleLabel: UILabel!
    @IBOutlet weak var dreamPriceLabel: UILabel!
    @IBOutlet weak var dreamPriceGoalLabel: UILabel!
    @IBOutlet weak var dreamProgressView: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        dreamMainView.layer.cornerRadius = 5
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
