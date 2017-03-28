//
//  ServiceWrapper.swift
//  ServicesIntegration
//
//  Created by NGI-Raheel Mateen on 03/10/2015.
//  Copyright © 2015 NGI-Raheel Mateen. All rights reserved.
//

import Foundation

// Wrapper Class Use to Wrap the Data
class ServiceWrapper {

    /**
    ** Static Function for Sign Up the User
    ** @param    ->
    ** @response ->
    **/
    static func signUp( requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary, error : NSError.Type) -> Void) {
            
            let apiName: NSString  = "http://10.0.0.69/f_b/users/signup"
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(requestObject, apiName:apiName) { (success, response, error) -> Void in
                
                // If Succesfully Call the Api
                if (success) {
                    print(response, terminator: "")
                }
            }
            
    }

    
}