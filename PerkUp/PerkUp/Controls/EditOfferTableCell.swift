//
//  EditOfferTableCell.swift
//  PerkUp
//
//  Created by NGI-Noman on 29/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

public protocol EditOfferTableCellDelegate{
    
    func deleteOfferFromList(sender:AnyObject);
    
}

class EditOfferTableCell: UITableViewCell {
    
    var customDelegate:EditOfferTableCellDelegate?

  //  @IBOutlet weak var clock_icon: UIImageView!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblDealSave: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblRemainingQuantity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    //@IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDealAmount: UILabel!
    @IBOutlet weak var lblSaveRupees: UILabel!
    @IBOutlet weak var lblDiscountType: UILabel!
    
    @IBOutlet weak var bottomDealAmount: NSLayoutConstraint!
    @IBOutlet weak var topDealAmount: NSLayoutConstraint!
    
    @IBOutlet weak var btnCross: UIButton!
    
    var _offer_id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblDealSave.layer.cornerRadius = Constant.CommonRadius
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRectMake(0,0,400,SizeUtil.convertIphone6ToIphone5(230))
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
        
        
        lblAddress.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(10));
        lblRemainingQuantity.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblTitle.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(12));
//        lblDescription.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(10));
       // lblTime.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(9));
        lblDealAmount.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(14));
        lblSaveRupees.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(12));
        
        lblSaveRupees.hidden = true
        lblDealAmount.hidden = true
        lblDealSave.hidden = true
        //lblTime.hidden = true
       // clock_icon.hidden = true
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func didTapOnCrossBtn(sender: AnyObject) {
        
        customDelegate?.deleteOfferFromList(sender);
        
    }
    func setCellData(booking:Booking){
        
        
        imgBanner.downloadedFrom(link:(booking.offer?.offer_image)!);
        
        lblRemainingQuantity.text = "Only "+(booking.offer?.offer_available!)!+" Left"
        lblTitle.text = (booking.offer?.business_name!)!
        
        lblDescription.text = booking.offer?.offer_title!
        lblAddress.text = booking.offer?.locality!
        
                         print(booking.offer?.locality!)

        
        
        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
        var attrStr = NSMutableAttributedString(string:"0");
        
        
        for item in (booking.offer?.offer_nature_value!)! {
            if item.key as! String == "offerNatureValue"{
                
                if let number = Int(item.value as! String) {
                    let myNumber = NSNumber(integer:number)
                    lblDealAmount.hidden = false
                    lblDealAmount.text = "Rs." + String(myNumber)
                    bottomDealAmount.constant = SizeUtil.convertIphone6ToIphone5(12)
                    lblDiscountType.hidden = true
                    
                } else {
                    lblDealAmount.hidden = true
                    lblDealSave.hidden = true
                    
                    lblDiscountType.clipsToBounds = true
                    lblDiscountType.layer.cornerRadius = Constant.CommonRadius
                    lblDiscountType.layer.masksToBounds = true
                    lblDiscountType.text! = item.value as! String
                    lblDiscountType.hidden = false
                }
                
            }
            if  item.key as! String ==  "discountDiscountedPrice" {
                
                lblDiscountType.hidden = true
                lblDealAmount.text = "Rs." + String(item.value)
                lblDealAmount.hidden = false

                
            }
            if item.key as! String == "discountOriginalPrice" {
                
                lblDiscountType.hidden = true
                attrStr = NSMutableAttributedString(string:"Rs." + String(item.value))
                attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
                lblSaveRupees.attributedText = attrStr
                lblSaveRupees.hidden = false

            }
            
            
            
            
        }

        
//        
//        
//        if let discountInPercent = booking.offer?.discountPercentageOff {
//            lblDealSave.text = discountInPercent + "% OFF"
//            lblDealSave.hidden = false
//            lblDealSave.backgroundColor = UIColor.perkupOrange()
//            lblDealSave.clipsToBounds = true
//            lblDealSave.layer.cornerRadius = Constant.CommonRadius
//            lblDealSave.layer.masksToBounds = true
//        }
//
//        if let originalPrice = booking.offer?.discountOriginalPrice {
//            lblDealAmount.text = "Rs." + String(originalPrice)
//            lblDealAmount.hidden = false
//        }
//        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
//        var attrStr = NSMutableAttributedString(string:"0");
//        if booking.offer?.discountDiscountedPrice != nil{
//            attrStr = NSMutableAttributedString(string:"Rs." + String((booking.offer?.discountDiscountedPrice!)!))
//            attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
//            lblSaveRupees.attributedText = attrStr
//            lblSaveRupees.hidden = false
//        }
//
//        var retailerTime = ""
//        
//        if let startTime = booking.offer?.start_operating_time{
//            retailerTime = startTime
//        }
//        if let endTime = booking.offer?.end_operating_time{
//            retailerTime +=  " - " + endTime
//        }
        
      //  lblTime.text = retailerTime
        
        
        if let offer_id = booking.booking_id {
            
            _offer_id = offer_id
            
        }
        
        
    }
    
    ///
    
    func setCellDataForSaveOffer(saveOffer:SaveOffer){
        
        
        imgBanner.downloadedFrom(link:(saveOffer.offer?.offer_image)!);
        
        lblRemainingQuantity.text = "Only "+(saveOffer.offer?.offer_available!)!+" Left"
        lblTitle.text = (saveOffer.offer?.business_name!)!
        
        lblDescription.text = saveOffer.offer?.offer_title!
        lblAddress.text = saveOffer.offer?.locality!
        
        // Editing
        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
        var attrStr = NSMutableAttributedString(string:"0");
        
        
        for item in (saveOffer.offer?.offer_nature_value!)! {
            if item.key as! String == "offerNatureValue"{
                
                if let number = Int(item.value as! String) {
                    let myNumber = NSNumber(integer:number)
                    lblDealAmount.hidden = false
                    lblDealAmount.text = "Rs." + String(myNumber)

 bottomDealAmount.constant = SizeUtil.convertIphone6ToIphone5(12)
                    lblDiscountType.hidden = true
                    
                } else {
                    lblDealAmount.hidden = true
                    lblDealSave.hidden = true
                    
                    lblDiscountType.clipsToBounds = true
                    lblDiscountType.layer.cornerRadius = Constant.CommonRadius
                    lblDiscountType.layer.masksToBounds = true
                    lblDiscountType.text! = item.value as! String
                    lblDiscountType.hidden = false
                }
                
            }
            if  item.key as! String ==  "discountDiscountedPrice" {
                
                lblDiscountType.hidden = true
                lblDealAmount.text = "Rs." + String(item.value)
                lblDealAmount.hidden = false

                
            }
            if item.key as! String == "discountOriginalPrice" {
                
                lblDiscountType.hidden = true
                attrStr = NSMutableAttributedString(string:"Rs." + String(item.value))
                attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
                lblSaveRupees.attributedText = attrStr
                lblSaveRupees.hidden = false
                
            }
            
            
            
            
        }
        
        
//        if let discountInPercent = offer.discountPercentageOff {
//            lblDealOff.text = discountInPercent + "% OFF"
//            lblDealOff.hidden = false
//            lblDealOff.backgroundColor = UIColor.perkupOrange()
//            lblDealOff.clipsToBounds = true
//            lblDealOff.layer.cornerRadius = Constant.CommonRadius
//            lblDealOff.layer.masksToBounds = true
//        }
//
//        
        
        
        
        
        
        
        
        
        
        
        
//        if let discountInPercent = saveOffer.offer?.discountPercentageOff {
//            lblDealSave.text = discountInPercent + "% OFF"
//            lblDealSave.hidden = false
//            lblDealSave.backgroundColor = UIColor.perkupOrange()
//            lblDealSave.clipsToBounds = true
//            lblDealSave.layer.cornerRadius = Constant.CommonRadius
//            lblDealSave.layer.masksToBounds = true
//        }
//        
//        if let originalPrice = saveOffer.offer?.discountOriginalPrice {
//            lblDealAmount.text = "Rs." + String(originalPrice)
//            lblDealAmount.hidden = false
//        }
////        let strikeThrough = [NSStrikethroughStyleAttributeName: 1]
////        var attrStr = NSMutableAttributedString(string:"0");
//        if saveOffer.offer?.discountDiscountedPrice != nil{
//            attrStr = NSMutableAttributedString(string:"Rs." + String((saveOffer.offer?.discountDiscountedPrice!)!))
//            attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
//            lblSaveRupees.attributedText = attrStr
//            lblSaveRupees.hidden = false
//        }
//        
        var retailerTime = ""
        
        if let startTime = saveOffer.offer?.start_operating_time{
            retailerTime = startTime
        }
        if let endTime = saveOffer.offer?.end_operating_time{
            retailerTime +=  " - " + endTime
        }
        
      //  lblTime.text = retailerTime
        
        
        if let offer_id = saveOffer.favorite_id {
            
            _offer_id = offer_id
            
        }
        
        
    }
    
    
    
}
