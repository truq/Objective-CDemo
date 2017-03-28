//
//  HelperUtil.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/16/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import UIKit


class HelperUtil: NSObject {
    
    static func openUrl(urlString : String){
        
        /*
        @parma  Url String
        @open open link in safari web brwoser
        */
        
        UIApplication.sharedApplication().openURL(NSURL(string:urlString)!);
    }
    
    static func mailTo(mailAddress: String){
        /* 
        @parma  mail address
        @open mail composer
        */
        
        let url = NSURL(string:mailAddress);
        UIApplication.sharedApplication().openURL(url!);
    }
    
    static func loadDataFromPlist(plistName:String) -> NSDictionary{
        
        /*
        @parma  Void
        @load data from xml type file(plist) and parase in Dictonary
        @return NSDictonary
        */
        
        var dict: NSDictionary? //  ? type optional
        if let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist") {
            dict = NSDictionary(contentsOfFile: path);
        }
        return dict!;
        
    }
    
    static func getViewFromNib(nibName : String) -> UINib{
        /*
        @parma  string  Xib File Name
        @load View From Xib's
        @return Nib file
        */
        let nib = UINib(nibName: nibName, bundle: nil);
        return nib;
        
    }
    
    static func extendDictionry(dict : NSDictionary) -> NSDictionary{
        
        let mutableDict = NSMutableDictionary(dictionary: dict);
        mutableDict.addEntriesFromDictionary(Constant.defaultDict as [NSObject : AnyObject])
        print(mutableDict)
        return mutableDict
        
    }
    
    static func updateMenuTable(){
        dispatch_async(dispatch_get_main_queue(), {
            NSNotificationCenter.defaultCenter().postNotificationName("", object: nil)
        })
    }

    
}