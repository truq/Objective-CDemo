//
//  RetailersDetailViewCell.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 01/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit

class RetailersDetailViewCell: UITableViewCell {
    
    @IBOutlet weak var pointsNeeded: UILabel?
    @IBOutlet weak var pointsRewards: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}