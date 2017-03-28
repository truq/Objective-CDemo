//
//  Alert.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/7/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import Foundation
import UIKit

class Alert: NSObject {
    
   static var loadingAlert : MBProgressHUD!
    
    static func showLoader(message : String){
        
        loadingAlert = MBProgressHUD.showHUDAddedTo(AppDelegate.getInstatnce().window!, animated: true)
        loadingAlert.label.text = message
        
        
    }
    static func hideLoader(){
        
        MBProgressHUD.hideHUDForView(AppDelegate.getInstatnce().window!, animated: true)
        
        
    }
    
    static func showAlert(title : String,message : String){
        
        if #available(iOS 8.0, *) {
        
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // do something after completation
        }
        alert.addAction(alertAction)
        AppDelegate.getInstatnce().window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
                    
        }
        else{
            
            let alert = UIAlertView()
            alert.title = title as String
            alert.message  = message as String
            alert.addButtonWithTitle("OK")
            alert.show()
            
        }
        
    }
    
    static func showToast(message:String){
    
        
        loadingAlert = MBProgressHUD.showHUDAddedTo(AppDelegate.getInstatnce().window!, animated: true)
        loadingAlert.label.text = message
        loadingAlert.label.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(13))!
        loadingAlert.mode = MBProgressHUDMode.Text
        loadingAlert.margin = 15
        loadingAlert.offset.y = 200
        loadingAlert.removeFromSuperViewOnHide = true
        loadingAlert.hideAnimated(true, afterDelay: 1.5)
        

    }
}





