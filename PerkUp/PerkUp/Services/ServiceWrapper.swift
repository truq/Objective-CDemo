//
//  ServiceWrapper.swift
//  ServicesIntegration
//
//  Created by NGI-Raheel Mateen on 03/10/2015.
//  Copyright © 2015 NGI-Raheel Mateen. All rights reserved.
//

import Foundation

// Base url of Perk Up
let Base_Url = "https://dev.getperkup.com/webapp/api/"

// Send Code Url
let Send_Code = Constant.baseUrlForSecure + "mobileapp/sendCode"

// Sign Up 
let Sign_Up = Constant.baseUrlForSecure + "mobileapp/signup"

//access token 
let Access_token = Base_Url + "oauth/access_token"

// user profile
let User_Profile = Base_Url + "me"

// my retailers 
let My_Retailers = Base_Url + "me/retailers"

// my retailers with business id
let My_Retailer_BusinessID = Base_Url + "me/retailer"

// my rewards with business id
let My_Rewards = Base_Url + "customers/reward"

let Fetch_FB_Reward = Constant.baseUrlForSecure + "customers/facebook/"

let Connect_With_FB = Constant.baseUrlForSecure + "customer/fbConnect"

let Fetch_City_List = "https://dev.getperkup.com/webapp/public_api/city"


// Wrapper Class Use to Wrap the Data
class ServiceWrapper {

    /**
    ** Static Function for sendCode
    ** @param    ->
    ** @response ->
    **/
    class func sendCode( requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObject(requestObject, apiName:Send_Code) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                    completionHandler(success: success, response:response)
            }
            
    }
    
    
    /**
     ** Static Function for sign Up
     ** @param    ->
     ** @response ->
     **/
    class func signUp( requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObject(requestObject, apiName:Sign_Up) { (success, response) -> Void in
                
                    completionHandler(success: success, response:response)
            }
            
    }
    
    /**
     ** Static Function for sign Up
     ** @param    ->
     ** @response ->
     **/
    class func accessToken( requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObject(requestObject, apiName:Access_token) { (success, response) -> Void in
                
                    completionHandler(success: success, response:response)
            }
            
    }
    
    /**
     ** Static Function for user Profile
     ** @param    ->
     ** @response ->
     **/
    class func userProfile( requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObject(requestObject, apiName:User_Profile) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                    completionHandler(success: success, response:response)
            }
            
    }
    
    /**
     ** Static Function for my retailers
     ** @param    ->
     ** @response ->
     **/
    class func myRetailers(header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: requestObject, apiName:My_Retailers) { (success, response) -> Void in
                
                    completionHandler(success: success, response:response)
            }
            
    }
    
    /**
     ** Static Function for my retailers
     ** @param    ->
     ** @response ->
     **/
    class func myRetailersWithBusinessID( businessID:NSString, header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: requestObject, apiName:My_Retailer_BusinessID+"/"+(businessID as String)) { (success, response) -> Void in
                
                    completionHandler(success: success, response:response)
            }
            
    }
    
    /**
     ** Static Function for my retailers
     ** @param    ->
     ** @response ->
     **/
    class func myRewardsWithBusinessID( businessID:NSString, header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: requestObject, apiName:My_Rewards+"/"+(businessID as String)) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                    completionHandler(success: success, response:response)
            }
            
    }

    class func postUserFBDetail(header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObjectAndHeader(header,requestObject: requestObject, apiName:Connect_With_FB) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    class func getOfferToEarnPoints( businessID:NSString, header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: requestObject, apiName:Fetch_FB_Reward+(businessID as String)) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    
    //// Offer Services 
    class func getCityList(
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
         // adding Header
            Servicelayer.getDataWithObjectGet(Fetch_City_List,header:["":""],  params: ["":""]) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
            }
            
    }
    
    // Changing
    class func getFeaturedOffer(apiName:String,header:NSDictionary,params:NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            // Call the function to Hit the POST request
            // Adding Header
        
        Servicelayer.getDataWithObjectGet(apiName,header:header,  params:params ) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
                print(response)
            
            }
            
    }
    
    
    
    
    
    
    class func getAreaByCity(apiName:String,header: NSDictionary, params:NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
        Servicelayer.getDataWithObjectGet(apiName, header : header, params:params ) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
            }
            
    }
    class func getOfferByID(apiName:String,header:NSDictionary, params:NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
        Servicelayer.getDataWithObjectGet(apiName, header: header,params:params ) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
            }
            
    }
    class func getAllOfferByRetailer(apiName:String,header: NSDictionary, params:NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            Servicelayer.getDataWithObjectGet(apiName,header:header, params:params ) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
            }
            
    }
    
    class func bookOffer(apiName:String ,header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObjectAndHeader(header,requestObject: requestObject, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    class func getAllBookedOffer( apiName:String, header:NSDictionary, param: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: param, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    class func removeBookedOffer(apiName:String ,header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.deleteDataWithObjectAndHeader(header,requestObject: requestObject, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    
    class func saveOffer(apiName:String ,header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.postDataWithObjectAndHeader(header,requestObject: requestObject, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
        
    }
    class func getAllSavedOffer( apiName:String, header:NSDictionary, param: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.getDataWithObject(header,requestObject: param, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    
    class func removeSavedOffer(apiName:String ,header:NSDictionary, requestObject: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
            Servicelayer.deleteDataWithObjectAndHeader(header,requestObject: requestObject, apiName:apiName) { (success, response) -> Void in
                
                // If Succesfully Call the Api
                completionHandler(success: success, response:response)
            }
            
    }
    
    //
    class func updateUserProfile(apiName:String, header:NSDictionary, param: NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
            // Call the function to Hit the POST request
            
//            Servicelayer.getDataWithObject(header,requestObject: param, apiName:apiName) { (success, response) -> Void in
//                
//                print("Response update profile:",response)
//
//                                // If Succesfully Call the Api
//                completionHandler(success: success, response:response)
//                print("Response update profile:",response)
//
//            }
//        

    
        Servicelayer.putDataWithObjectAndHeader(header,requestObject: param, apiName:apiName) { (success, response) -> Void in
            
            
            if success{
            
                   print(response)
            }
            
            // If Succesfully Call the Api
            completionHandler(success: success, response:response)
        }

    
    
    }
    
    
    
    
    //search api
    class func searchOfferByString(apiName:String,header: NSDictionary, params:NSDictionary,
        completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
            
            
        Servicelayer.getDataWithObjectGet(apiName,header:header,  params:params ) {
                (success, response) -> Void in
                completionHandler(success: success, response:response)
            }
            
    }
    
    class func registerDeviceOnServer( requestObject: NSDictionary,
                         completionHandler:
        (success : Bool, response : NSDictionary) -> Void) {
        // Call the function to Hit the POST request
        Servicelayer.postDataWithObject(requestObject, apiName:Constant.urlForRegDevice) { (success, response) -> Void in
            // If Succesfully Call the Api
            completionHandler(success: success, response:response)
        }
        Alert.hideLoader();
        
    }
    
    
}