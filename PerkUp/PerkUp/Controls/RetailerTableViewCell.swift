//
//  RetailerTableViewCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 14/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class RetailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgRetailer: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLoyalty: UILabel!
    @IBOutlet weak var lblBonusPromo: UILabel!
    @IBOutlet weak var lblActiveOffer: UILabel!
    
    @IBOutlet weak var btnPTS: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnPTS.layer.cornerRadius = Constant.CommonRadius;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCellData(data:NSDictionary){
        
        print("\(data)");
        
        var dictData : AnyObject!
        
        dictData = data.objectForKey("retailer") as! NSDictionary
        
        imgRetailer.downloadedFrom(link: dictData.objectForKey("profilePic") as! String)
        lblName.text = dictData.objectForKey("name") as? String;
        
        dictData = data.objectForKey("customer") as! NSDictionary
        
       // btnPTS.setTitle(StringUtil.mergeTwoStringBySpace((dictData.objectForKey("totalPoints") as? String)!, strTwo: "PTS") , forState: UIControlState.Normal)
          btnPTS.setTitle(dictData.objectForKey("totalPoints") as? String, forState: UIControlState.Normal)
        
        
        dictData = data.objectForKey("haveLoyalty") as! NSArray
        lblLoyalty.text = "\(dictData.count) Loyalty Rewards";
        
        dictData = data.objectForKey("bonusReward") as! NSArray
        lblBonusPromo.text = "\(dictData.count) Bonus Promotions";
        
        dictData = data.objectForKey("offers") as! NSDictionary
        lblActiveOffer.text = "\(dictData.objectForKey("activeOfferCount") as! NSNumber) Active Offers";
        
    }
    
}
