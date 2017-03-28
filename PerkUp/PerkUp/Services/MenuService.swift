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
        
        if (_mainMenu != nil){
            return _mainMenu
        }
        
      _mainMenu=[getBrowseOfferMenu(),getSavedOfferMenu(),getMyRetailersMenu(),getPerkUpMenu(),getSettingsMenu(), getLogOutMenu()]

        return _mainMenu;
        
    }
    
    func getBrowseOfferMenu() -> Menu{
        
        let menu  = Menu(menuName: "Browse Offers", menuImageUrl:"browse-offer")
        print(menu, terminator: "")
        return menu
    }
    func getSavedOfferMenu() -> Menu{
        let menu  = Menu(menuName: "Saved Offers", menuImageUrl:"saved-offer")
        return menu
    }
    func getMyRetailersMenu() -> Menu{
        
        let menu  = Menu(menuName: "My Retailers", menuImageUrl:"retailers")
        return menu
    }
    func getPerkUpMenu() -> Menu{
        let menu  = Menu(menuName: "My PerkUp", menuImageUrl:"my-perkup")
        return menu
    }
    func getInviteMenu() -> Menu{
        let menu  = Menu(menuName: "Invite Friends", menuImageUrl:"invite-friend")
        return menu
    }
    func getSettingsMenu() -> Menu{
        let menu  = Menu(menuName: "Settings", menuImageUrl:"settings")
        return menu
    }
    func getFeedbackMenu() -> Menu{
        let menu  = Menu(menuName: "Feedback", menuImageUrl:"feedback")
        return menu
    }
    func getLogOutMenu() -> Menu{
        let menu  = Menu(menuName: "LogOut", menuImageUrl:"logout")
        return menu
    }

   
}
