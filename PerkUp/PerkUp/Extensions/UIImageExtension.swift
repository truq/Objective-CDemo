//
//  UIImageExtension.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/13/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadedFrom(link link:String) {
        guard
            let url = NSURL(string: link)
            else {return}
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            
            
            Alamofire.getInstance.request(.GET,url).response() {
                (_, _, data, _) in
                let image = UIImage(data: data! )
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.image = image
                    
                })
                
                
            }
            
            
        })
        
    }
}
