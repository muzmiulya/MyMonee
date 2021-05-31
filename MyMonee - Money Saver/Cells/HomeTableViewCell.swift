//
//  HomeTableViewCell.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func datas(select: UsageHistory) {
        titleLabel.text = select.usageName ?? ""
        dateLabel.text = select.usageDate ?? ""
        priceLabel.text = "\(select.usagePrice ?? 0)"
        if select.status {
            imageStatus.image = UIImage(named: "Arrow_Up")
            priceLabel.text = "+Rp \(select.usagePrice?.convertIntToCurrency() ?? "")"
            priceLabel.textColor = UIColor(red: 33/256, green: 150/256, blue: 83/256, alpha: 1.0)
        } else {
            imageStatus.image = UIImage(named: "Arrow_Down")
            priceLabel.text = "-Rp \(select.usagePrice?.convertIntToCurrency() ?? "")"
            priceLabel.textColor = UIColor(red: 235/256, green: 87/256, blue: 87/256, alpha: 1.0)
        }
    }
}
