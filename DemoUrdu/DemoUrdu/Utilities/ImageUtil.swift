//
//  ImageUtil.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/13/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class ImageUtil {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : ImageUtil? = nil
    }
    
    class var sharedInstance : ImageUtil{
        
        dispatch_once(&Static.onceToken){
            
            Static.instance = ImageUtil()
            
        }
        return Static.instance!
        
    }
    
    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
            completion(data: NSData(data: data!))
            }.resume()
    }
    
    func setImageFromUrl(url:String , imageView:UIImageView){
        
        imageView.kf_showIndicatorWhenLoading = true
        imageView.kf_setImageWithURL(NSURL(string:url )!, placeholderImage: nil,
                                      optionsInfo: [.Transition(ImageTransition.Fade(1))],
                                      progressBlock: { receivedSize, totalSize in
                                        print(":\(receivedSize)/\(totalSize)")
            },
                                      completionHandler: { image, error, cacheType, imageURL in
                                        print(": Finished")
        })
    }
    
    
}
