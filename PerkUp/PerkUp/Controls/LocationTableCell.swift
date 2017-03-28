//
//  LocationTableCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 29/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class LocationTableCell: UITableViewCell {

    @IBOutlet weak var clock_icon: UIImageView!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var toplblDealAmount: NSLayoutConstraint!
    //@IBOutlet weak var lblDealSave: UILabel!
    //var _offer : Offer!

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRemainingQuantity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDealAmount: UILabel!
    @IBOutlet weak var lblSaveRupees: UILabel!
    @IBOutlet weak var lblDealOff: UILabel!
    @IBOutlet weak var btnSaveOffer: UIButton!
    var _offer_id = ""
    var offerId: String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // lblDealSave.layer.cornerRadius = Constant.CommonRadius
        
        setButton(btnSaveOffer)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRectMake(0,0,400,242)
        gradient.startPoint = CGPointMake(0, 0.4);
        gradient.endPoint = CGPointMake(0, 1);
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        imgBanner.layer.insertSublayer(gradient, atIndex: 0)
        
        imgBanner.contentMode = UIViewContentMode.ScaleToFill
        imgBanner.autoresizingMask = [
            .FlexibleBottomMargin,
            .FlexibleHeight
            ,.FlexibleLeftMargin
            ,.FlexibleRightMargin
            ,.FlexibleTopMargin
            ,.FlexibleWidth];
        
        
        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
        let attrStr = NSMutableAttributedString(string: "Rs.10,000");
        attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
        lblSaveRupees.attributedText = attrStr
        
    
      //  lblAddress.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(10));
        lblRemainingQuantity.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblTitle.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
//        lblDescription.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(10));
       
        lblDealAmount.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblSaveRupees.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        
        lblSaveRupees.hidden = true
        lblDealAmount.hidden = false
       // lblDealSave.hidden = true
       // clock_icon.hidden = true
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(offer:Offer){
        
        offerId = offer.offer_id
        imgBanner.downloadedFrom(link: offer.offer_image!);
        
        lblRemainingQuantity.text = "Only "+offer.offer_available!+" Left"
        lblTitle.text = offer.business_name
        
        lblDescription.text = offer.offer_title
        lblAddress.text = offer.locality
        
        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
        var attrStr = NSMutableAttributedString(string:"0");

        for item in offer.offer_nature_value! {
            if item.key as! String == "offerNatureValue"{
                
                if let number = Int(item.value as! String) {
                    let myNumber = NSNumber(integer:number)
                    lblDealAmount.text = "Rs." + String(myNumber)
                    
                } else {
                    lblDealAmount.text! = item.value as! String

                }
                lblDealOff.hidden = true
                
            }
            if  item.key as! String ==  "discountDiscountedPrice" {
                lblDealAmount.text = "Rs." + String(item.value)
                lblDealAmount.hidden = false
                toplblDealAmount.constant = 10
                lblDealOff.hidden = true
                
                
            }
            if item.key as! String == "discountOriginalPrice" {
                attrStr = NSMutableAttributedString(string:"Rs." + String(item.value))
                attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
                lblSaveRupees.attributedText = attrStr
                lblSaveRupees.hidden = false
                lblDealOff.hidden = true
                
            }
            
            if item.key as! String == "discountPercentageOff" {
                lblDealOff.text = String(item.value) + "% OFF"
                lblDealOff.hidden = false
                lblDealOff.backgroundColor = UIColor.perkupOrange()
                lblDealOff.clipsToBounds = true
                lblDealOff.layer.cornerRadius = Constant.CommonRadius
                lblDealOff.layer.masksToBounds = true
                lblDealAmount.hidden = true
                lblSaveRupees.hidden = true
                
                
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
        
        
        if let offer_id = offer.offer_id {
            
            _offer_id = offer_id
            
        }
      
        
        
        
        
        
    }
    @IBAction func saveOffer(sender: UIButton){
    
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            return
        }
        
        self.saveOffer();
    }
    func saveOffer(){
       
        
        print("welcome",offerId)
        
        let dict = ["favoriteObjectId": offerId,
                    "access_token":UserModel.getUserToken(),
                    "favoriteType":"USER_FAVORITE_TYPE_OFFER"]
        
        print("Dictionary",dict)
        
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
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 2, 0);button.layer.borderWidth = 0
            button.layer.cornerRadius = 6
            button.backgroundColor = UIColor.clearColor()
            button.layer.borderColor = UIColor.perkupGreen().CGColor
            button.titleLabel?.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(17))
        
    }
    
   // btnInviteFriend.backgroundColor = UIColor.perkupBlue()

    
    }




