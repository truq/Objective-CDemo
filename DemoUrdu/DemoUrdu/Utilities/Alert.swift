//
//  Alert.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/7/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import Foundation
import MBProgressHUD


class Alert: NSObject {
    
   static var loadingAlert : MBProgressHUD!
    
    static func showLoader(message : String){
        
        loadingAlert = MBProgressHUD.showHUDAddedTo(AppDelegate.getInstatnce().window, animated: true)
        loadingAlert.labelText = message
        
        
    }
    static func hideLoader(){
        
        MBProgressHUD.hideHUDForView(AppDelegate.getInstatnce().window, animated: true)
        
        
    }
    
    static func showAlert(title : String,message : String){
        
            let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                // do something after completation
            }
            alert.addAction(alertAction)
            AppDelegate.getInstatnce().window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
            
    }
    static func showToast(message:String){
        
        loadingAlert = MBProgressHUD.showHUDAddedTo(AppDelegate.getInstatnce().window, animated: true)
        loadingAlert.labelText = message
        loadingAlert.labelFont = UIFont(name: "Arial", size: SizeUtil.convertIphone6ToIphone5(13))
        loadingAlert.mode = MBProgressHUDMode.Text
        loadingAlert.margin = 15
        loadingAlert.yOffset = 200
        loadingAlert.removeFromSuperViewOnHide = true
        loadingAlert.hide(true, afterDelay: 1.5)
        
    }
}



//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//
//
//        if segue.identifier == "sw_main2dash"{
//
//            let vc = segue.destinationViewController as! PaymentInfoController
//
////            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "timerDidFire:", userInfo: userInfo, repeats: true)
////
////                    dispatch_async(dispatch_get_main_queue()) {
////            }
//
//        }
//    }




