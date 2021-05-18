//
//  QuotesCell.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/04/2021.
//

import UIKit

class QuotesCell: UICollectionViewCell {
    
    //MARK:- Properties
    
    @IBOutlet weak var lblQuotetxt: UILabel!
    @IBOutlet weak var lblAuthorTxt: UILabel!
    @IBOutlet weak var btnfavourite: UIButton!
    @IBOutlet weak var btnShareTapped: UIButton!


    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
