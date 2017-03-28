//
//  UserModel.swift
//  PerkUp
//
//  Created by NGI-Noman on 11/03/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation

class UserModel : NSObject {
    
    static func setUserToken(userToken:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userToken, forKey: "user_token");
        
    }
    static func getUserToken()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_token")!;
    }
    static func setUserPin(userPin:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userPin, forKey: "user_pin");
        
    }
    static func getUserPin()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_pin")!;
    }
    
    static func setTokenForRefresh(refreshToken:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(refreshToken, forKey: "refresh_user_token");
        
    }
    static func getTokenForRefresh()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("refresh_user_token")!;
    }
    
    static func setExpiredTimeOfToken(time:String){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(time, forKey: "refresh_time");
    }
    static func getExpiredTimeOfToken()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("refresh_time")!;
    }
    static func setTokenIsExpired(state:Bool){
      
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "is_token_expired");
    }
    static func isTokenExpired()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("is_token_expired");
    }
    
    static func setUserSessionKey(userSession:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        guard userSession == ""  else{
            defaults.setValue(userSession, forKey: "user_session");

        return
        }
        
        
    }
    static func getUserSessionKey()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        return defaults.stringForKey("user_session")!;
    }
    
    static func setUserName(userName:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userName, forKey: "user_name");
        defaults.synchronize()
        
    }
    static func getUserName()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_name")!;
    }
    static func setUserEmail(userName:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userName, forKey: "user_email");
        defaults.synchronize()
        
    }
    static func getUserEmail()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_email")!;
    }
    static func setUserPhoneNumber(userNumber:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userNumber, forKey: "user_phone");
        defaults.synchronize()
        
    }
    static func getUserPhoneNumber()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_phone")!;
    }
    static func setUserJoinDate(userJoinDate:String){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(userJoinDate, forKey: "user_join_date");
        
    }
    static func getUserJoinDate()->String{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("user_join_date")!;
    }
    
    static func setUserLoggedIn(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "user_login");
    }
    static func isUserLoggedIn()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("user_login");
    }
    
    static func setConnectedFromFb(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "connected_fb");
    }
    static func isConnectedFromFb()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("connected_fb");
    }
    
    
    static func saveUserCityName(cityName:String){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(cityName, forKey: "city_name");
    }
    static func getUserCityName()->String{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.stringForKey("city_name")!
        
    }
    
    static func setUserHasCity(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "user_has_city");
    }
    static func isUserHasCity()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("user_has_city");
    }
    
    static func saveUserDealCount(dealCount: Int){
        
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setInteger(dealCount, forKey: "dealCount")
        
    }
    static func getUserDealCount() -> Int{
        
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.integerForKey("dealCount")

    }
    static func setRetailerNotificationActive(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "retailer_notification");
    }
    static func canUserReceiveRetailerNotification()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("retailer_notification");
    }
    
    static func setOfferNotificationActive(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "offer_notification");
    }
    static func canUserReceiveOfferNotification()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("offer_notification");
    }
    
    static func setControllerName(name: String){
       
        let defaults = NSUserDefaults.standardUserDefaults()

        
//        guard name == "" else {
//            // Value requirements not met, do something
//            defaults.setValue(name, forKey:"controllerName")
//
//            return
//        }
        
        
        
        defaults.setValue(name, forKey:"controllerName")

        
        
    
    }
    
    static func getControllerName()-> String{
     let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.objectForKey("controllerName") as! String
        
    
    }
    
    
    static func setUserId(name: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(name, forKey:"customer_id")
        
    }
    
    static func getUserId()-> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.objectForKey("customer_id") as! String
        
        
    }
    //customer_id
    
    static func setDeviceTokenRegisterd(state:Bool){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setBool(state, forKey: "DeviceTokenRegisterd");
    }
    static func isDeviceTokenRegisterd()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults();
        return defaults.boolForKey("DeviceTokenRegisterd");
    }
    
    static func setUserDeviceToken(name: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(name, forKey:"UserDeviceToken")
        
    }
    
    static func getUserDeviceToken()-> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey("UserDeviceToken") as! String
        
        
    }
}


