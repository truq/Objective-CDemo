//
//  MenuService.swift
//  SlideViewDemo
//
//  Created by NGI-NOMAN on 9/29/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class MenuService: NSObject {
    
    var _mainMenu : NSArray!
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : MenuService? = nil
    }
    
    class var sharedInstance : MenuService {
        
        // MARK : - Create Singleton
        
        dispatch_once(&Static.onceToken) {
            Static.instance = MenuService()
        }
        return Static.instance!
    }
    
    func getMainMenu() -> NSArray{
        
//        if (_mainMenu != nil){
//            return _mainMenu
//        }
        
        _mainMenu=[getBrowseOrganizationMenu(),getHistoryMenu(),getSettingMenu(),getPaymentInfoMenu(),getContactUsMenu(),getManageOrganizationMenu(),getStatsMenu(),getLogOutMenu()]
        
        return _mainMenu;
        
    }
    
    func getBrowseOrganizationMenu() -> Menu{
        
        let menu  = Menu(menuName: "Browse Organization", menuImageUrl:"BrowseOrganization.png")
        print(menu, terminator: "")
        return menu
    }
    func getHistoryMenu() -> Menu{
        let menu  = Menu(menuName: "History", menuImageUrl:"history-icon.png")
        return menu
    }
    func getSettingMenu() -> Menu{
        
        let menu  = Menu(menuName: "Profile", menuImageUrl:"settings-icon.png")
        return menu
    }
    func getPaymentInfoMenu() -> Menu{
        let menu  = Menu(menuName: "Payment Info", menuImageUrl:"PaymentInfo-icon.png")
        return menu
    }
    func getContactUsMenu() -> Menu{
        
        let menu  = Menu(menuName: "Contact Us", menuImageUrl:"contact-icon.png")
        return menu
    }
    func getManageOrganizationMenu() -> Menu{
        let menu  = Menu(menuName: "SignUp Oraganization", menuImageUrl:"clander-icon.png")
        return menu
    }
    func getStatsMenu() -> Menu{
        
        let menu  = Menu(menuName: "About Us", menuImageUrl:"aboutus-icon.png")
        return menu
    }
    func getLogOutMenu() -> Menu{
        let menu  = Menu(menuName: "Log out", menuImageUrl:"logout-icon.png")
//            if !UserModel.isUserLoggedIn(){
//            menu  = Menu(menuName: "Log In", menuImageUrl:"logout-icon.png")
//        }
        return menu
    }
   
}
