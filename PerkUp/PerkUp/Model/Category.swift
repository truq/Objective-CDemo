//
//  Category.swift
//  PerkUp
//
//  Created by NGI-Noman on 07/04/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation


class Category : NSObject {
    
    var name : String?
    var category_id : String?
    
    func setDatafromServer(dict:NSDictionary){
        
        name = dict.objectForKey("name") as? String;
        category_id = dict.objectForKey("category_id") as? String;

    }
    
}