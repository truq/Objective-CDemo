//
//  DetailAlertTableViewCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 17/03/2016. i dislike red Color in text
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit



class DetailAlertTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(fbDetail:NSDictionary,pageData:NSDictionary,index:Int){
        
        switch (index){
            
        case 0:
            lblDescription.text = Constant.fbLikeDes
            lblPoints.text = StringUtil.mergeTwoStringBySpace((fbDetail.objectForKey("pointsPageLike") as? String)!, strTwo:Constant.pts)
            break;
        case 1:
            lblDescription.text = StringUtil.mergeTwoStringBySpace(Constant.fbCheckInDes, strTwo: pageData.objectForKey("name") as! String)
            lblPoints.text = StringUtil.mergeTwoStringBySpace((fbDetail.objectForKey("pointsCheckIn") as? String)!, strTwo: Constant.pts)
            break;
        case 2:
            lblDescription.text = Constant.fbPostReviewDec.stringByReplacingOccurrencesOfString("%@", withString: pageData.objectForKey("name") as! String)
            lblPoints.text = StringUtil.mergeTwoStringBySpace((fbDetail.objectForKey("pointsPostingReview") as? String)!, strTwo:Constant.pts)
            break;
        default:
            break
            
        }
        
        
    }

}
