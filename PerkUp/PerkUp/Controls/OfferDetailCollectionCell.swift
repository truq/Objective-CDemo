//
//  OfferDetailCollectionCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 05/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class OfferDetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        self.layer.cornerRadius = 6
//        image.contentMode = UIViewContentMode.ScaleAspectFit
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCellImageData(imageLink:String){
        
        image.downloadedFrom(link: imageLink)

    }
}
