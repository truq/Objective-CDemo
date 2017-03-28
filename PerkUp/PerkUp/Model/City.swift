//
//  Area.swift
//  PerkUp
//
//  Created by NGI-Noman on 07/04/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation


class City : NSObject {
    
    var area : String?
    var area_id : String?
    var city : String?
    var country : String?
    
    func setDatafromServer(dict:NSDictionary){
        
        area = dict.objectForKey("area") as? String;
        area_id = dict.objectForKey("area_id") as? String;
        city = dict.objectForKey("city") as? String;
        country = dict.objectForKey("country") as? String
    }

}