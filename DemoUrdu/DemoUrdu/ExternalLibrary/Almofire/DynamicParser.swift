//
//  DynamicParser.swift
//  ServicesIntegration
//
//  Created by NGI-Raheel Mateen on 02/10/2015.
//  Copyright © 2015 NGI-Raheel Mateen. All rights reserved.
//

import Foundation

// Class for dynamic parsing the json respone
class DynamicParser:NSObject {
    /**
    *  Method  get Selector name from server key-value
    *  @parameter              -> key: hash value pair from server response
    *  @returm                 -> SEL: name of Selector
    */
    static func getSelecterNameForKey ( jsonKey : NSString) -> Selector {
        
        // make the keys
        let keyString = String(format: "set%@%@:", jsonKey.substringToIndex(1).lowercaseString,
            jsonKey.substringToIndex(1).uppercaseString)
        
        return  NSSelectorFromString(keyString)
    }
    
    /**
    *  Method  bind value with Selector
    *  @parameter              -> object: object of refrence class, selector: name of selector, value: value bind with selector
    *  @returm                 -> SEL: name of Selector
    */
    static func setValueForObject ( object : AnyObject, selector : Selector,
        value : AnyObject) -> Void  {
        
            // Check the value if NULL
            if (  value as! NSNull != NSNull() ) {
                
                // If true
                if ( object.respondsToSelector(selector) ) {
                    
                    // Set the Object
                    // swift 2
                   // object.performSelector(selector, withObject: value)
                    
                    //swift 1
                    NSTimer.scheduledTimerWithTimeInterval(0, target: object, selector: Selector(value as! String), userInfo: nil, repeats: false)
                }
                
            }
    }
}

