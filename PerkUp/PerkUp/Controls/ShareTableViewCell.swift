//
//  ShareTableViewCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 22/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class ShareTableViewCell: UITableViewCell {

    var indexOfCell:Int!
    @IBOutlet weak var labelCellTitle: UILabel!
    @IBOutlet weak var imageCellShare: UIImageView!
    @IBOutlet weak var btnCellShare: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    
         print("index of Cell\(indexOfCell)")
        
    
    }
    
    
    
    
    @IBAction func changeState(sender: AnyObject) {
        
    }
}
