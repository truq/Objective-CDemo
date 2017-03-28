//
//  OfferTableCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 29/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class OfferTableCell: UITableViewCell {
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblDealOff: UILabel!
    @IBOutlet weak var btnSaveOffer: UIButton!
    
    @IBOutlet weak var viewHighlighter: UIView!
    @IBOutlet weak var lblVHcounter: UILabel!
    @IBOutlet weak var lblVHTitle: UILabel!
    
    
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    
    @IBOutlet weak var lblDealDiscription: UILabel!
    
    
    @IBOutlet weak var viewDiscount : UIView!
    @IBOutlet weak var lblSaveRupees: UILabel!
        
    
    
    @IBOutlet weak var lblAddress: UILabel!
    var offerId: String!

        var _offer_id = ""
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setButton(btnSaveOffer)
        
        
        viewHighlighter.backgroundColor = UIColor.alertBGColor()
        lblVHcounter.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblVHTitle.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(12));
        lblDealDiscription.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblDiscountPrice.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblOriginalPrice.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblAddress.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(10));
        viewDiscount.hidden = false
        lblDealOff.hidden = true
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
    
    func setCellData(offer:Offer){
        
        offerId = offer.offer_id
        imgBanner.downloadedFrom(link: offer.offer_image!);
        
        lblVHcounter.text = "Only "+offer.offer_available!+" Left"
        lblVHTitle.text = offer.business_name
        
        lblDealDiscription.text = offer.offer_title
        lblAddress.text = offer.business_address
        
        //
        for item in offer.offer_nature_value!{
            if item.key as! String == "offerNatureValue"{
                viewDiscount.hidden = true
                lblDiscount.text! = item.value as! String
                print(".................ITEM VAlue .........",item.value)
            }
            
            
            if item.key as! String == "discountOriginalPrice"{
                viewDiscount.hidden = false
                
                lblOriginalPrice.text = String(offer.discountOriginalPrice)
                print("discount price ",offer.discountDiscountedPrice)
               
                if let originalPrice = offer.discountOriginalPrice {
                    lblOriginalPrice.text = "Rs." + String(originalPrice)
                    
                    print("Original price", originalPrice)
                    
                    
                }
                let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
                var attrStr = NSMutableAttributedString(string:"0");
                if offer.discountOriginalPrice != nil{
                    attrStr = NSMutableAttributedString(string:"Rs." + String(offer.discountDiscountedPrice!))
                    attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
                    lblDiscountPrice.attributedText = attrStr
                    lblDiscountPrice.hidden = false
                }
                


                print("ITEM VAlue ",item.value)
            }
            
        }

        
        
        
        if let discountInPercent = offer.discountPercentageOff {
            lblDealOff.text = discountInPercent + "% OFF"
            lblDealOff.hidden = false
            lblDealOff.backgroundColor = UIColor.perkupOrange()
            lblDealOff.clipsToBounds = true
            lblDealOff.layer.cornerRadius = Constant.CommonRadius
            lblDealOff.layer.masksToBounds = true
        }
        
        
        
        
        
        
        
        
//        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
//        var attrStr = NSMutableAttributedString(string:"0");
//        if offer.discountOriginalPrice != nil{
//            attrStr = NSMutableAttributedString(string:"Rs." + offer.discountDiscountedPrice!)
//            attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
//           lblSaveRupees.attributedText = attrStr
//           lblSaveRupees.hidden = false
//        }
//        
        
        
        
        if let offer_id = offer.offer_id {
            
            _offer_id = offer_id
            
        }
        
        
    }
    
    @IBAction func saveOffer(sender: AnyObject) {
        
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            return
        }
        
        self.saveOffer();

        
    }
    
    func saveOffer(){
        
        let dict = ["favoriteObjectId": offerId,
                    "access_token":UserModel.getUserToken(),
                    "favoriteType":"USER_FAVORITE_TYPE_OFFER"]
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        ServiceWrapper.bookOffer("\(Constant.baseUrlForSecure)userfavorites",header: header, requestObject:dict) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                Alert.showAlert("", message: "Offer Saved Successfully")
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }



    func setButton(button:UIButton){
        
        
        
        button.titleLabel?.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5((button.titleLabel?.font.pointSize)!))
        button.layer.cornerRadius = Constant.CommonRadius
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 2, 0);button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.clearColor()
        button.layer.borderColor = UIColor.perkupGreen().CGColor
        button.titleLabel?.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(17))
        
    }
    



}
