//
//  Offer.swift
//  PerkUp
//
//  Created by NGI-Noman on 06/04/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation


class Offer: NSObject {
    
    var about : String?
    var business_address : String?
    var business_id : String?
    var business_name : String?
    
    var discountDiscountedPrice : Int?
    var discountOriginalPrice : Int?
    
    var locality:String?
    var discountPercentageOff : String?
   
    
    var end_operating_time : String?
    var expiry_date : String?
    var gallery : NSArray?
    var number_of_friend : String?
    var offer_available : String?
    var offer_id : String?
    var offer_image : String?
    var offer_nature : String?
    var offer_nature_value : NSDictionary?
    var offer_title : String?
    var on_going : Bool?
    // Sharing Parameters
    var offerNatureValue : String?
    var is_inviteable: Bool?
    var sharing_message: String?
    var sharing_subject: String?
    var sharing_url: String?
    var friend_discount: String?
    var start_operating_time : String?
    var terms : String?
    
    func setDatafromServer(dict:NSDictionary){
        
        about = dict.objectForKey("about") as? String;
        business_address = dict.objectForKey("business_address") as? String;
        business_id = dict.objectForKey("business_id") as? String;
        business_name = dict.objectForKey("business_name") as? String;
        discountDiscountedPrice = dict.objectForKey("discountDiscountedPrice") as? Int
        discountOriginalPrice = dict.objectForKey("discountOriginalPrice") as? Int
        discountPercentageOff = dict.objectForKey("discountPercentageOff") as? String
        end_operating_time = dict.objectForKey("end_operating_time") as? String;
        expiry_date = dict.objectForKey("expiry_date") as? String
        gallery = dict.objectForKey("gallery") as? NSArray
        number_of_friend = dict.objectForKey("number_of_friend") as? String;
        offer_available = dict.objectForKey("offer_available") as? String;
        offer_id = dict.objectForKey("offer_id") as? String;
        offer_image = dict.objectForKey("offer_image") as? String;
        offer_nature = dict.objectForKey("offer_nature") as? String;
        offer_nature_value = dict.objectForKey("offer_nature_value") as? NSDictionary;
        offerNatureValue = dict.objectForKey("offerNatureValue") as? String;
        offer_title = dict.objectForKey("offer_title") as? String;
        on_going = dict.objectForKey("on_going") as? Bool;
        // new Parameters
        is_inviteable = dict.objectForKey("is_inviteable") as? Bool;
        friend_discount = dict.objectForKey("friend_discount") as? String;
        sharing_message = dict.objectForKey("sharing_message") as? String;
        sharing_subject = dict.objectForKey("sharing_subject") as? String;
        sharing_url = dict.objectForKey("sharung_url") as? String;
        locality = dict.objectForKey("locality") as? String
        // End 
        start_operating_time = dict.objectForKey("start_operating_time") as? String;
        terms = dict.objectForKey("terms") as? String;
        
        
        
    }
    
}