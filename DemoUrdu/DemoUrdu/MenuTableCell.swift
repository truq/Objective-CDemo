//
//  MenuTableCell.swift
//  SlideViewDemo
//
//  Created by NGI-NOMAN on 9/29/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {
    
    
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var viewSeperator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        menuNameLabel.adjustsFontSizeToFitWidth = true
        menuNameLabel.minimumScaleFactor = 0.5
        menuNameLabel.font = UIFont(name: "HelveticaNeue", size: SizeUtil.convertIphone6ToIphone5(15))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
