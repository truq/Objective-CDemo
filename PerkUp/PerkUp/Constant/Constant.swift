//
//  Constant.swift
//  PTequity
//
//  Created by NGI-NOMAN on 11/11/2015.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    
    override init() {
        super.init()
    }
    
    
    static let defaultDict : NSDictionary = [
        "platform":"iOS",
        "platform_version":UIDevice.currentDevice().systemVersion,
        "device_id":UIDevice.currentDevice().identifierForVendor!.UUIDString,
        "app_version":"1.0",
        "appType": "equity"
    ];

    static let CommonRadius : CGFloat = 4.0

    static let AppFontBold = "Montserrat-Bold"
    static let AppFontRegular = "Montserrat-Regular"
    static let iPhoneFontSize : CGFloat = 17
    
    static let pts = "PTS"
    static let PList = "plist"
    static let ProfilePlist = "profile"
    
    static let updateSideMenu = "update_side_menu"
    
    //MArk : Constant For User
    static let kUserFName = "first_name"
    static let kUserLName = "last_name"
    static let kUserFullName = "full_name"
    static let kUserName = "user_name"
    static let kUserAuthkey = "auth_key"
    static let kUserEmail = "email"
    static let kUserPwd = "password"
    static let kUserId = "member_id"
    static let kUserImageUrl = "image_url"
    
    //Service API URL's
    static let baseUrlForOffer = "https://getperkup.com/webapp/public_api/"
    static let baseUrlForSecure = "https://getperkup.com/webapp/api/"
    static let urlForRegDevice = baseUrlForSecure + "mobileapp/registerDevice"
    static let signup = ""
    static let login = ""
    static let forgotPassword = ""
    static let fblikeUrl = "http://facebook.com/"

    
    static let GoogleMapKey = ""
    static let TwtConsumerKey = ""
    static let TwtSecret = ""
    static let GoogleClientId = ""
    static let fbAppLinkUrl = "https://fb.me/1649284585342285"
    static let FB_Secret = "03b5a49762436c7fecb37669213b182c"
    static let siteURL = ""
    
    //Mark: Static Facebook Like Popup Data 
    
    static let fbLikeDes = "Like Facebook Page"
    static let fbCheckInDes = "Check In On Facebook when visiting"
    static let fbShareDes = "Share any Facebook post to earn points"
    static let fbPostReviewDec = "Post a Facebook Review %@ on Facebook to earn points"
    
    
    // MArk: ControllerIdentifier 
    
    // Mark : Constant For Segues
    static let sw_featured = "sw_featured"
    static let sw_categories = "sw_categories"
    static let sw_locations = "sw_locations"
    static let sw_embed_container = "sw_embed_container"
    static let sw_pushtolocation = "pushtolocation"
    static let sw_pushtofeatured = "pushtofeatured"
    static let sw_pushtocategory = "pushtocategory"
    static let sw_pushtosavedoffer = "pushtosaved"
    static let sw_pushtobookedoffer = "pushtobooked"
    static let sw_pushtoalloffer = "pushtoalloffer"
    static let sw_push_all_to_detail = "pushfromalloffer_todetail"
    
    
}
