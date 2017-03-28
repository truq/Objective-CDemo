//
//  Menu.swift
//  SlideViewDemo
//
//  Created by NGI-NOMAN on 9/29/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class Menu: NSObject {
    
    var name : String!
    var imageUrl : String!
    
    init(menuName : String , menuImageUrl : String) {
        self.name = menuName
        self.imageUrl = menuImageUrl
    }
   
}
