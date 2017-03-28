//
//  Booking.swift
//  PerkUp
//
//  Created by NGI-Noman on 12/04/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation

class Booking: NSObject {
    
    var booking_id : String?
    var business_id : String?
    var customer_id : String?
    var offer : Offer?
    var offer_id : String?
    
    
    func setDataFromServer(dict:NSDictionary){
        
        booking_id = dict.objectForKey("booking_id") as? String;
        business_id = dict.objectForKey("business_id") as? String;
        customer_id = dict.objectForKey("customer_id") as? String;
        offer_id = dict.objectForKey("offer_id") as? String;
        
        if let offerData = dict.objectForKey("offer") as? NSDictionary{
            
            offer = Offer()
            offer?.setDatafromServer(offerData)
        }
    }
}
