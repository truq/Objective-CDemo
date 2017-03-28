//
//  CustomTableViewCell.swift
//  DemoTableView
//
//  Created by NGI-NOMAN on 9/21/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var layerView : UIView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var LocationLabel : UILabel!
    @IBOutlet var thumbnail : UIImageView!
    @IBOutlet var rightArrowBtn : UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
