//
//  HelperUtil.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/16/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import Foundation


class HelperUtil: NSObject {
    
    
    static func setLastOrg(state : Bool){
         let defaults = NSUserDefaults.standardUserDefaults()
         defaults.setBool(state, forKey: "IslastOrg")
    
    }
    static func hasLastOrg() -> Bool{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey("IslastOrg")
        
    }
    
    static func setIsFirstView(state : Bool){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(state, forKey: "isFirstView")
        
    }
    static func isFirstView() -> Bool{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey("isFirstView")
        
    }
    
    static func setDonationIsZakat(state : Bool){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(state, forKey: "DonationIsZakat")
        
    }
    static func isDonationIsZakat() -> Bool{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey("DonationIsZakat")
        
    }
    
    static func saveLastAppearedController(controllerName : String){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(controllerName, forKey: "controllerName")
        
    }
    static func getLastAppearedController() -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey("controllerName")!
        
    }
    
    static func saveLastDonatedAmount(amount : String){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(amount, forKey: "amountDonated")
        
    }
    static func getLastDonatedAmount() -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey("amountDonated")!
        
    }
    
    static func saveLastDonatedOrg(orgId : String){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(orgId, forKey: "LastDonatedOrg")
        
    }
    static func getLastDonatedOrg() -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey("LastDonatedOrg")!
        
    }
    
//    static func saveLastOrgData(org : Organization){
//        
//        /*
//        @parma Object of Organization
//        @make archive of object and save it
//        @return none
//        */
//        
//        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(org as Organization)
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(archivedObject, forKey: "lastOrgData")
//        defaults.synchronize()
//        
//    }
//    static func getLastOrgData()-> Organization?{
//        /*
//        @parma void
//        @ Unarchive of object and save it
//        @return object of organization
//        */
//        if let unarchivedObject = NSUserDefaults.standardUserDefaults().objectForKey("lastOrgData") as? NSData {
//            return NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? Organization
//        }
//        return nil
//    }
  
    static func setDeviceTokenSent(state : Bool){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(state, forKey: "DeviceTokenSent")
        
    }
    static func isDeviceTokenSent() -> Bool{
        
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey("DeviceTokenSent")
        
    }
    
    
    
//    static func openUrl(urlString : String){
//        UIApplication.sharedApplication().openURL(NSURL(string:urlString)!)
//    }
//    static func mailTo(mailAddress: String){
//        let url = NSURL(string:mailAddress)
//        UIApplication.sharedApplication().openURL(url!)
//    }

    
}