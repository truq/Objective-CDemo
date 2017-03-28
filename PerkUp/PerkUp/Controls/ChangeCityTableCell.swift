//
//  ChangeCityTableCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 30/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit


public protocol ChangeCityTableDelegate{
    
    func didTapOnRadioButton(sender: UIButton);
    
}
class ChangeCityTableCell: UITableViewCell {
    
    var _customDelegate : ChangeCityTableDelegate?
    let _controller : ChangeCityController = ChangeCityController()

    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblcomingSoon: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblcomingSoon.hidden = true
        // Initialization code
    }
    @IBAction func didTapOnRadioBtn(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        if button.selected{
            button.selected = false
        }
        else{
          button.selected = true
        _customDelegate?.didTapOnRadioButton(button);
        }
        
    }

}
