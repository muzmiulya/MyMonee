//
//  HomeCollectionViewCell.swift
//  MyMonee - Money Saver
//
//  Created by MacBook on 12/05/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var arrowDirection: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var latestPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.layer.cornerRadius = 5
    }

}
