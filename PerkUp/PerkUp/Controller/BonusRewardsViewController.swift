//
//  BonusRewardsViewController.swift
//  PerkUp
//
//  Modified by NGI-Noman on 01/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit
class BonusRewardsViewController: BaseController, UITableViewDataSource, UITableViewDelegate {
    
    var response:NSArray!;
    var retailers: NSDictionary!;
    var _retailerName : String!
    var mobileNum: String!
    var retailerObject = Retailers()
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var callButton: UIButton?
    @IBOutlet weak var lblFooterInfo: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    var contactInfo: NSDictionary?

    
    
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if response.count == 0 {
            lblMessage.hidden = false
        }else{
            lblMessage.hidden = true
        }

        // getting first phone number
        for (key,value) in self.retailers.enumerate(){
            print("Key:\(key) value:\(value)")
            if value.key as! String  == "contactInfo" {
                print(" contact info :",value.value.objectAtIndex(key))
                contactInfo = value.value.objectAtIndex(0) as? NSDictionary
                print("welcome:",contactInfo)
            }
        }
             
        
        for item in contactInfo!{
        
            
            if item.key as! String == "contact_value"{
            mobileNum = item.value as! String
            }
            
        }
        
         print("mobile number", mobileNum)
        
        
        //print(contactInfo)
        
     //   print( "Mobile Number",mobileNum)
        
        //    guard self.response != nil else{
//                   print(" response is nil")
//        self.response = NSArray()
//        
//          return
//        }
        
        
        
//        
//        let dict = [
//            "access_token":UserModel.getUserToken(),
//            "business_id": self.response.valueForKey("retailer").valueForKey("customer")!.valueForKey("business_id") as! String];
//        
//        let header = [
//            "sessionkey":UserModel.getUserSessionKey()];
//        
//        print(header);
//        ServiceWrapper.myRewardsWithBusinessID( (self.response.valueForKey("retailer").valueForKey("customer")?.valueForKey("business_id"))! as! NSString, header: header, requestObject: dict) { (success, response) -> Void in
//            if (success) {
//                
//                
//                
//                NSLog("%@", response);
//        }
//        }

        
        createUI();
      
        
        
        
       NSLog("Bonus Reward ");
    }
    
    func createUI(){
        
        self.addLeftButton();
        
        tableView!.separatorStyle = .None
        tableView!.backgroundColor = UIColor.clearColor();
        
        callButton?.layer.cornerRadius = Constant.CommonRadius;
        
        callButton?.setTitle(StringUtil.mergeTwoStringBySpace("Call", strTwo: _retailerName), forState: UIControlState.Normal)
        
        lblFooterInfo.text = "visit \(_retailerName) with your card to redeem your bonus rewards"
        
        
        setNavigationTitleText("Bonus Rewards");
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : TableViewDelegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.response.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bonusCell", forIndexPath: indexPath) as! BonusRewardTableViewCell
        
        
        cell.number?.text = String(format: "%d", indexPath.row + 1);
        
        let str = self.response[indexPath.row].valueForKey("rewardExpiry") as? String
        cell.percent?.text = self.response[indexPath.row].valueForKey("rewardMsg") as? String;
        cell.date?.text = "Expires: " + (str?.substringWithRange(Range<String.Index>(start: (str?.startIndex.advancedBy(0))!, end: (str?.endIndex.advancedBy(-8))!)))!
            cell.selectionStyle = .None
        
        return cell
    }
    
    @IBAction func didTapOnCallButton(sender: AnyObject) {
        
        
        
        
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(mobileNum)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
}
