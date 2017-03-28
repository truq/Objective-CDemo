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
    // reserved class object once in memory
    class var sharedInstance : SizeUtil{
        
        dispatch_once(&Static.onceToken){
            
            Static.instance = SizeUtil()
            
        }
        return Static.instance!
        
    }
    
    class func screenWidth() -> CGFloat {
        // screen width according to device canvas
        return UIScreen.mainScreen().bounds.width
    }
    class func screenHeight() -> CGFloat {
       // screen Height according to device canvas
        return UIScreen.mainScreen().bounds.height
    }
    
    class func convertIphone6ToIphone5(size : CGFloat) -> CGFloat{
        
        /*
        Resize View to thier Canvas area
        */
        
        var tempSize = size;
        
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().bounds.height{
                
            case 260:
                //print("iPhone Classic")
                tempSize = ( size * 72.3 ) / 100 ;
            case 480:
                // print("iPhone 4 or 4S")
                tempSize = ( size * 72.3 ) / 100 ;
            case 568:
                //print("iPhone 5 or 5S or 5C")
                tempSize = ( size * 85.3 ) / 100 ;
            case 667:
                //print("iPhone 6 or 6S")
                tempSize = size;
            case 1104:
                // print("iPhone 6+ or 6S+")
                tempSize = ( size * 110.47 ) / 100 ;
            default: break
//                print("", terminator: "")
            }
        }
        else{
            
             switch UIScreen.mainScreen().bounds.height {
             case 1024 :
                tempSize = (size * 125) / 100
             case 2732 :
                tempSize = (size * 187) / 100
             default: break
//                print("other", terminator: "")
            }
            
            //        1366.0 ipad pro
            //        1024.0
            
            //        1024.0 ipad retina ,2 ,air,air 2
            //        768.0
        }
        
        return tempSize
    }
    
    static func isIPAD()-> Bool{
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            //iPad
            return true
        }
        
        return false
        
    }
    static func isPortrait() -> Bool{
        
        if UIDevice.currentDevice().orientation.isPortrait{
            return true
        }
        
        return false
        
    }
    
}
