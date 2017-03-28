//
//  ServiceLayer.swift
//  PerkUp
//
//  Created by NGI-Noman on 09/03/2016.
//  Copyright © 2015 NGI-Noman. All rights reserved.
//

import Foundation
import UIKit

class Servicelayer: NSObject {
    

    /**
     ** POST Method for calling API
     *  Services gateway
     *  Method  get response from server
     *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
     *  @returm                 -> void
     *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
     **/
    static func postDataWithObject( requestObject: NSDictionary, apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Show the loader
            Alert.showLoader("");
            
            // Make Url
            let url = NSURL(string: apiName as String)
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.getInstance.request(.POST, url!, parameters:requestObject as? [String : AnyObject])
                .responseJSON {responseResult in
                    Alert.hideLoader()
                    debugPrint(responseResult)     // prints detailed description of all response properties
                    
                    print(responseResult.request)  // original URL request
                    print(responseResult.response) // URL response
                    print(responseResult.data)     // server data
                    print(responseResult.result)   // result of response serialization
                    
                    if let JSON = responseResult.result.value as? NSDictionary{
                        print("JSON: \(JSON)")
                        
                        if let status = JSON.objectForKey("status") as? String{
                            
                            if  status == "success"{
                                
                                completionHandler(success: true, response:JSON)
                            }
                            else{
//                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")
                                completionHandler(success: false, response:JSON)
                            }
                            
                        }
                        
                       else if let error = JSON.objectForKey("error") as? String{
                            
//                            self.showAlertView(error, title:"Server Error")
                            print(error)
                            
                            completionHandler(success: false, response:JSON)
                            
                        }
                        else{
                            completionHandler(success: true, response:JSON)
                        }
                        
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
    static func getDataWithObject(header: NSDictionary, requestObject: NSDictionary,apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Show the loader
            Alert.showLoader("")
            // Make Url
            let url = NSURL(string: apiName as String)
            
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.getInstance.request(.GET, url!, parameters:requestObject as? [String : AnyObject] ,headers:header as? [String : String] )
                .responseJSON {responseResult in
                    Alert.hideLoader()
                    // prints detailed description of all response properties
                    
                    print(responseResult.request)  // original URL request
                    print(responseResult.response) // URL response
                    print(responseResult.data)     // server data
                    print(responseResult.result)   // result of response serialization
                    
                    if let JSON = responseResult.result.value as? NSDictionary{
                        print("JSON of Register: \(JSON)")
                        
                        if let status = JSON.objectForKey("status") as? String{
                            
                            if  status == "success"{
                                
                                completionHandler(success: true, response:JSON)
                            }
                            else{
//                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")                    
                                
                                // this is done by ayaz
                                  UserModel.setUserLoggedIn(false)
                                
                                completionHandler(success: false, response:JSON)
                            }
                            
                        }
                        
                        else if let error = JSON.objectForKey("error") as? String{
                            print(error)
//                                self.showAlertView(error, title:"Server Error")
                            
                            completionHandler(success: false, response:JSON)
                            
                        }
                        else{
                            completionHandler(success: true, response:JSON)
                        }
                        
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
    static func postDataWithObjectAndHeader(header: NSDictionary, requestObject: NSDictionary,apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Show the loader
            Alert.showLoader("")
            // Make Url
            let url = NSURL(string: apiName as String)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.getInstance.request(.POST, request, parameters:requestObject as? [String : AnyObject] ,headers:header as? [String : String] )
                .responseJSON {responseResult in
                    Alert.hideLoader()
                    // prints detailed description of all response properties
                    
                    print(responseResult.request)  // original URL request
                    print(responseResult.response) // URL response
                    print(responseResult.data)     // server data
                    print(responseResult.result)   // result of response serialization
                    
                    if let JSON = responseResult.result.value as? NSDictionary{
                        print("JSON: \(JSON)")
                        
                        if let status = JSON.objectForKey("status") as? String{
                            
                            if  status == "success"{
                                
                                completionHandler(success: true, response:JSON)
                            }
                            else{
//                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")
                                completionHandler(success: false, response:JSON)
                            }
                            
                        }
                            
                        else if let error = JSON.objectForKey("error") as? String{
                            
                            print(error)
//                            self.showAlertView(error, title:"Server Error")
                            
                            completionHandler(success: false, response:JSON)
                            
                        }
                        else{
                            completionHandler(success: true, response:JSON)
                        }
                        
                    }
                    
            }
    }
    
    /// get data without header // adding header
    static func getDataWithObjectGet( apiName : NSString,header: NSDictionary, params :NSDictionary,
        completionHandler: (success : Bool, response : NSDictionary) -> Void){
        
            // Make Url
            let url = NSURL(string: apiName as String)
            
            // Call the method to request and wait for the response
            // @param  ->
            // @return ->
            Alamofire.getInstance.request(.GET, url!, parameters:params as? [String : AnyObject],encoding: .URL)
                .responseJSON {responseResult in
                    Alert.hideLoader()
                    debugPrint(responseResult)     // prints detailed description of all response properties
                    
                    print(responseResult.request)  // original URL request
                    print(responseResult.response) // URL response
                    print(responseResult.data)     // server data
                    print(responseResult.result)   // result of response serialization
                    
                    if let JSON = responseResult.result.value as? NSDictionary{
                        print("JSON: \(JSON)")
                        
                        if let status = JSON.objectForKey("status") as? String{
                            
                            if  status == "success"{
                                
                                completionHandler(success: true, response:JSON)
                            }
                            else{
//                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")
                                completionHandler(success: false, response:JSON)
                            }
                            
                        }
                            
                        else if let error = JSON.objectForKey("error") as? String{
                            print(error)
//                            self.showAlertView(error, title:"Server Error")
                            
                            completionHandler(success: false, response:JSON)
                            
                        }
                        else{
                            completionHandler(success: true, response:JSON)
                        }
                        
                    }
                    
            }
    }
    /**
     ** Delete Method for calling API
     *  Services gateway
     *  Method  get response from server
     *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
     *  @returm                 -> void
     *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
     **/
    static func deleteDataWithObjectAndHeader(header: NSDictionary, requestObject: NSDictionary,apiName : NSString,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Show the loader
            Alert.showLoader("")
            // Make Url
            let URL:NSURL! = NSURL(string: apiName as String)
            Alamofire.getInstance.request(.DELETE, URL, parameters: requestObject as? [String : String], headers: header as? [String : String])
                .responseJSON {responseResult in
                    Alert.hideLoader()
                    // prints detailed description of all response properties
                    
                    print(responseResult.request)  // original URL request
                    print(responseResult.response) // URL response
                    print(responseResult.data)     // server data
                    print(responseResult.result)   // result of response serialization
                    
                    if let JSON = responseResult.result.value as? NSDictionary{
                        print("JSON: \(JSON)")
                        
                        if let status = JSON.objectForKey("status") as? String{
                            
                            if  status == "success"{
                                
                                completionHandler(success: true, response:JSON)
                            }
                            else{
//                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")
                                completionHandler(success: false, response:JSON)
                            }
                            
                        }
                            
                        else if let error = JSON.objectForKey("error") as? String{
                            print(error)
//                            self.showAlertView(error, title:"Server Error")
                            
                            completionHandler(success: false, response:JSON)
                            
                        }
                        else{
                            completionHandler(success: true, response:JSON)
                        }
                        
                    }
                    
            }
    }
    
    
    
  // Put Data ayaz
    
    static func putDataWithObjectAndHeader(header: NSDictionary, requestObject: NSDictionary,apiName : NSString,
                                            completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
        
        // Show the loader
        Alert.showLoader("")
        // Make Url
        let url = NSURL(string: apiName as String)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        // Call the method to request and wait for the response
        // @param  ->
        // @return ->
        Alamofire.getInstance.request(.PUT, request, parameters:requestObject as? [String : AnyObject] ,headers:header as? [String : String] )
            .responseJSON {responseResult in
                Alert.hideLoader()
                // prints detailed description of all response properties
                
                print(responseResult.request)  // original URL request
                print(responseResult.response) // URL response
                print(responseResult.data)     // server data
                print(responseResult.result)   // result of response serialization
                
                if let JSON = responseResult.result.value as? NSDictionary{
                    print("JSON: \(JSON)")
                    
                    if let status = JSON.objectForKey("status") as? String{
                        
                        if  status == "success"{
                            
                            completionHandler(success: true, response:JSON)
                        }
                        else{
                            //                                self.showAlertView(JSON.objectForKey("message") as! String, title:"")
                            completionHandler(success: false, response:JSON)
                        }
                        
                    }
                        
                    else if let error = JSON.objectForKey("error") as? String{
                        
                        print(error)
                        //                            self.showAlertView(error, title:"Server Error")
                        
                        completionHandler(success: false, response:JSON)
                        
                    }
                    else{
                        completionHandler(success: true, response:JSON)
                    }
                    
                }
                
        }
    }    
    
    // Shoe the alert View
    static func showAlertView (message:NSString,title:NSString) {
        let alert = UIAlertView()
        alert.title = title as String
        alert.message  = message as String
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
}
