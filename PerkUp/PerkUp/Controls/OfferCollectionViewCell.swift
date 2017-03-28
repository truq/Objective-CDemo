//
//  OfferCollectionViewCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 29/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.grayColor().CGColor
        //        viewContainer.layer.cornerRadius = viewContainer.bounds.width*0.18

        viewContainer.layer.cornerRadius = viewContainer.bounds.width*0.15
        viewContainer.layer.masksToBounds = true
        viewContainer.backgroundColor = UIColor.clearColor()
    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    func setCellData(area:City){
        lblTitle.text = area.area
        
    }
    func setCellDataForCategory(category:Category){
        super.selected = true
        lblTitle.text = category.name
        print(category.category_id)
        
    }

}
