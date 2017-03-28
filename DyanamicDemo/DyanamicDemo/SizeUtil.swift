//
//  SizeUtil.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/6/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import Foundation
import UIKit


class SizeUtil {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : SizeUtil? = nil
    }
    
    class var sharedInstance : SizeUtil{
        
        dispatch_once(&Static.onceToken){
            
            Static.instance = SizeUtil()
            
        }
        return Static.instance!
        
    }
    
    class func convertIphone6ToIphone5(size : CGFloat) -> CGFloat{
        
        /*
             Resize View to thier Canvas area
        */
        
        var tempSize = size;
        
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
            case 480:
                //print("iPhone Classic")
                tempSize = ( size * 72.3 ) / 100 ;
            case 960:
               // print("iPhone 4 or 4S")
                tempSize = ( size * 72.3 ) / 100 ;
            case 1136:
                //print("iPhone 5 or 5S or 5C")
                tempSize = ( size * 85.3 ) / 100 ;
            case 1334:
                //print("iPhone 6 or 6S")
                tempSize = size;
            case 2208:
               // print("iPhone 6+ or 6S+")
                tempSize = ( size * 110.47 ) / 100 ;
            default:
                break
//                print("other", terminator: "")
            }
        }
        
        
        return tempSize
    }
    
}
