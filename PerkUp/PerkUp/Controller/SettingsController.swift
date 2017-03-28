//
//  SettingsController.swift
//  PerkUp
//
//  Created by NGI-Noman on 31/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

enum NOTIFICATION_TYPE:Int{
    case OFFER_NOTIFICATION = 1
    case RETAILER_NOTIFICATION = 2
    
}

class SettingsController: BaseController,TruqDropDownDelegate{

    var dropDown:TruqDropDown!
    
    @IBOutlet weak var btnDropDown: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeButton(){
        
        btnDropDown.layer.shadowOpacity = 0.5
        btnDropDown.layer.shadowRadius = Constant.CommonRadius
        btnDropDown.layer.cornerRadius = Constant.CommonRadius
        btnDropDown.layer.shadowOffset =  CGSizeMake(0, 3);
        
        btnDropDown.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btnDropDown.titleLabel!.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        btnDropDown.imageView!.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
        let spacing :CGFloat = btnDropDown.frame.size.width * 0.9; // the amount of spacing to appear between image and title
        btnDropDown.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, spacing);
        btnDropDown.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        btnDropDown.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func didTapOnDropDown(sender: AnyObject) {
        
        
        let dropDownheight = self.view.frame.size.height - btnDropDown.frame.origin.y - btnDropDown.frame.size.height
        
       let cityArray = HelperUtil.loadDataFromPlist("cities").valueForKey("city") as! NSArray;
        if(dropDown == nil) {
            dropDown = TruqDropDown()
            dropDown.showDropDown(sender as! UIButton, height:dropDownheight , textArray: cityArray, direction: "down")
            dropDown.customDelegate = self
        }
        else {
            dropDown.hideDropDown(sender as! UIButton)
            dropDown = nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapOnCheckBox(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        if button.tag == NOTIFICATION_TYPE.OFFER_NOTIFICATION.rawValue && !button.selected{
            button.selected = true
            UserModel.setOfferNotificationActive(true)
            
        }
        else if button.tag == NOTIFICATION_TYPE.OFFER_NOTIFICATION.rawValue && button.selected{
            button.selected = false
            UserModel.setOfferNotificationActive(false)
            
        }
        
        if button.tag == NOTIFICATION_TYPE.RETAILER_NOTIFICATION.rawValue && !button.selected{
            button.selected = true
            UserModel.setRetailerNotificationActive(true)
            
        }
        else if button.tag == NOTIFICATION_TYPE.RETAILER_NOTIFICATION.rawValue && button.selected{
            button.selected = false
            UserModel.setRetailerNotificationActive(false)
            
        }
        
    }
    
    func setTitleLabel() {
       ///
    }
}
