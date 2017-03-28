//
//  BonusRewardTableViewCell.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 01/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit

class BonusRewardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bgLblView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        number.layer.masksToBounds = true
        number.layer.cornerRadius = number.bounds.width/2
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}