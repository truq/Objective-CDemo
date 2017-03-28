//
//  SaveOffer.swift
//  PerkUp
//
//  Created by NGI-Noman on 12/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation

class SaveOffer: NSObject {
    
    
    var favorites : String?
    var type : String?
    var customer_id : String?
    var offer : Offer?
    var favorite_id : String?
    
    
    func setDataFromServer(dict:NSDictionary){
        
        favorites = dict.objectForKey("favorites") as? String;
        type = dict.objectForKey("type") as? String;
        customer_id = dict.objectForKey("customer_id") as? String;
        favorite_id = dict.objectForKey("favorite_id") as? String;
        
        if let offerData = dict.objectForKey("detail") as? NSDictionary{
            
            offer = Offer()
            print("if Executed")
            offer?.setDatafromServer(offerData)
        }
        
    }

}
