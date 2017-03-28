//
//  ServiceLayer.swift
//  ServicesIntegration
//
//  Created by NGI-Raheel Mateen on 02/10/2015.
//  Copyright © 2015 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import Alamofire

class Servicelayer: NSObject {
    
    /**
    ** POST Method for calling API
    *  Services gateway
    *  Method  get response from server
    *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
    *  @returm                 -> void
    *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
    **/
    static func getDataWithObject( requestObject: NSDictionary, apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary, error : ErrorType?) -> Void) {
            
            // Make Url
            let url = NSURL(string: apiName as String)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.request(.POST, url!, parameters:requestObject as? [String : AnyObject], encoding: .JSON)
                .responseJSON {responseRequest, responseResponse, responseResult in
                    
                    // Switch for Success or Error
                    switch responseResult {
                        
                        // If the API return succesfull response
                    case .Success(let data):
                        
                        let data_ar = data as! NSDictionary
                        print(data_ar)
                        // Get the Status if 0 then error if 1 then succes
                        // From our server side
                        if let str = data_ar.valueForKey("OK") as? Bool {
                            
                            // Check if the status is OK and no error from
                            // our server side
                            if ( str ) {
                                
                                print("Response from Server %@", data_ar)
                                
                                // Cast the response and pss to handler
                                // To notify
                                completionHandler(success: true, response:data_ar
                                    , error:responseResult.error )
                            }
                            else {
                                print("Error from Our Server %@", data_ar)
                                let str = data_ar.valueForKey("message") as! NSString
                                Alert.hideLoader()
                                self.showAlertView(str, title: "Error From Server")
                                completionHandler(success: true, response:data_ar
                                    , error:responseResult.error )

                            }
                            
                        }
                        if let error = data_ar.valueForKey("jsonBody") as? NSDictionary{
                            
                            let dict = error.objectForKey("error")
                            Alert.hideLoader()
                            Alert.showAlert("Error From Server", message: dict?.objectForKey("message") as! String)

                        }
                        if let error = data_ar.valueForKey("code") as? String{
                            
                            print(error)
//                            let dict = error.objectForKey("error")
                            Alert.hideLoader()
                            Alert.showAlert("Error From Server", message: data_ar.objectForKey("message") as! String)
                            
                        }
            
                        
                    case .Failure(let data, let error):
                        Alert.hideLoader()
                        print("Request failed with error: \(error)")
                        print(data)
                        print((error as! NSError).localizedDescription)
                        self.showAlertView((error as! NSError).localizedDescription, title: "Error From Server")
                        
                    }
            }
    }
    
    
    /**
    ** GET Method for calling API
    *  Services gateway
    *  Method  get response from server
    *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
    *  @returm                 -> void
    *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
    **/
    static func getDataWithObjectGet( apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary, error : ErrorType?) -> Void) {
            
            // Make Url
            let url = NSURL(string: apiName as String)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.request(.GET, url!, parameters:nil , encoding: .JSON)
                .responseJSON {responseRequest, responseResponse, responseResult in
                    
                    // Switch for Success or Error
                    switch responseResult {
                        
                        // If the API return succesfull response
                    case .Success(let data):
                        let data_ar = data as! NSDictionary
                        
                        // Get the Status if 0 then error if 1 then succes
                        // From our server side
                        if let str = data_ar.valueForKey("OK") as? Bool {
                            
                            // Check if the status is OK and no error from
                            // our server side
                            if ( str ) {
                                
                                print("Response from Server %@", data_ar)
                                
                                // Cast the response and pss to handler
                                // To notify
                                completionHandler(success: true, response:data_ar
                                    , error:responseResult.error )
                            } else {
                                Alert.hideLoader()
                                print("Error from Our Server %@", data_ar)
                                let str = data_ar.valueForKey("message") as! NSString
                                self.showAlertView(str, title: "Error From Server")
                            }
                        }
                        
                        if let error = data_ar.valueForKey("code") as? NSDictionary{
                            
                            let dict = error.objectForKey("error")
                            Alert.hideLoader()
                            Alert.showAlert("Error From Server", message: dict?.objectForKey("message") as! String)
                            
                        }
                        
                        
                        if let error = data_ar.valueForKey("jsonBody") as? NSDictionary{
                            
                            let dict = error.objectForKey("error")
                            Alert.hideLoader()
                            Alert.showAlert("Error From Server", message: dict?.objectForKey("message") as! String)
                            
                        }
                        
                        // If the API fail
                    case .Failure(let data, let error):
                        Alert.hideLoader()
                        print("Request failed with error: \(error)")
                        print(data)
                        print((error as! NSError).localizedDescription)
                        self.showAlertView((error as! NSError).localizedDescription, title: "Error From Server")
                    }
            }
    }
    
    // Shoe the alert View
    static func showAlertView (message:NSString,title:NSString) {
        
        Alert.showAlert(title as String, message: message as String)

    }
    
}
