//
//  Retailers.swift
//  PerkUp
//
//  Created by NGI-Noman on 09/05/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation

class Retailers: NSObject{

    var retailer: NSDictionary?
    var business_address: NSString?
    var city: NSString?
    var contactInfo: NSArray?
    var contact_type: NSString?
    var contact_value: NSString?
    var name: NSString?
    var profilePic: NSString?
    var rewards: NSDictionary?
    var campaignName: NSString?
    var rewardCollectionsId:Int?
    var rewardExpiry: NSString?
    var rewardMsg: NSString?

    
    
    func setDatafromServer(dict:NSDictionary){
    
    
         retailer = dict.objectForKey("retailer") as? NSDictionary
         business_address = dict.objectForKey("business_address") as? String
         city = dict.objectForKey("city") as? String
         contactInfo = dict.objectForKey("contactInfo") as? NSArray
         contact_type = dict.objectForKey("contact_type") as? String
         contact_value = dict.objectForKey("contact_value") as? NSString
         name = dict.objectForKey("name") as? NSString
         profilePic = dict.objectForKey("profilePic") as? String
         rewards = dict.objectForKey("rewards") as? NSDictionary
         campaignName = dict.objectForKey("campaignName") as? String
         rewardCollectionsId = dict.objectForKey("rewardCollectionsId") as? Int
         rewardExpiry = dict.objectForKey("rewardExpiry") as? String
         rewardMsg = dict.objectForKey("rewardMsg") as? String
         print("Wow",dict)
        
        
    
    }
    
    
    
}