//
//  MyRetailerTableViewCell.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 29/02/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit

class MyRetailerTableViewCell: UITableViewCell {
    
    // IBOutLet
    @IBOutlet weak var retailersImage: UIImageView!
    @IBOutlet weak var retailersName: UILabel!
    @IBOutlet weak var totalPoints: UIButton!
    @IBOutlet weak var loyality: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var offers: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}