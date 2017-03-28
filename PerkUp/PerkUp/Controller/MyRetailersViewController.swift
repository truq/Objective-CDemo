//
//  MyRetailersViewController.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 29/02/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit
import Accounts



class MyRetailersViewController: BaseController, UITableViewDataSource, UITableViewDelegate{
    
    // IBoutlet
    @IBOutlet weak var tableView: UITableView?
    
    var selectedArray:NSArray = NSArray()
    
    @IBOutlet weak var btnBrowseOffer: UIButton!
    var response:NSDictionary!;
    
    
    @IBOutlet weak var viewGateway: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavigationTitleText("My Retailers");
        
         addRightButton();
        
        loadRetailersData()
        
        viewGateway.hidden = true
        
        btnBrowseOffer.layer.cornerRadius = Constant.CommonRadius
        btnBrowseOffer.backgroundColor = UIColor.perkupGreen()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func addRightButton(){
        let button = UIButton(frame: CGRectMake(0, view.center.y, 40, 40))
        button.setImage(UIImage(named: "notification"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(self.didTapOnRightButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        let label = UILabel(frame: CGRectMake(25,2,13,13))
        label.backgroundColor = UIColor.redColor();
        label.text = "2"
        label.textColor = UIColor.whiteColor()
        label.layer.cornerRadius = 13/2
        label.layer.masksToBounds = true
        label.clipsToBounds = true
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: Constant.AppFontRegular, size: 11)
        button.addSubview(label)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    
    func loadRetailersData(){
        
        let dict = [
            "access_token": UserModel.getUserToken(),
            "sessionkey":UserModel.getUserSessionKey()]
        
        print("dictionay",dict)
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        ServiceWrapper.myRetailers(header, requestObject: dict) { (success, response) -> Void in
            
            if (success) {
                NSLog("%@", response);
                self.selectedArray = response.objectForKey("retailers") as! NSArray;
                
                if (self.selectedArray.count == 0){
                    print("Noretailer Found")
                    self.viewGateway.hidden = false
                    self.navigationController?.navigationBarHidden = true
                    return;
                }
                
                // Reload the Table View
                self.tableView?.reloadData();
            }
            else{
                
                
                self.loadMainOffer()
               // Alert.showAlert("", message: "you also logged an other device");
            }
        }
        
    }
    
    // MARK : TableViewDelegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedArray.count;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(116);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier = "RetailerTableCell\(indexPath)"
        
        var cell:RetailerTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? RetailerTableViewCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("RetailerTableViewCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? RetailerTableViewCell
        }
        
        cell?.setCellData(self.selectedArray.objectAtIndex(indexPath.row) as! NSDictionary)
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dict = [
            "access_token":UserModel.getUserToken(),
            "business_id": self.selectedArray[indexPath.row].valueForKey("customer")!.valueForKey("business_id") as! String]
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        ServiceWrapper.myRetailersWithBusinessID( (self.selectedArray[indexPath.row].valueForKey("customer")?.valueForKey("business_id"))! as! NSString, header: header, requestObject: dict) { (success, response) -> Void in
            if (success) {
                NSLog("welcome To Retailer With Business Awards: %@", response);
                self.response = response;
                self.performSegueWithIdentifier("sw_detail", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "sw_detail" ) {
            
            if let detailViewController = segue.destinationViewController as? RetailersDetailViewController {
                detailViewController.response = self.response;
            }
        }
    }
    
    override func didTapOnRightButton() {
        let notificationViewController = storyboard!.instantiateViewControllerWithIdentifier("NotificationViewContlroller") as! NotificationViewContlroller
        self.navigationController?.pushViewController(notificationViewController, animated: true);
    }
    @IBAction func didTapOnBrowseOffer(sender: AnyObject) {
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("OfferMainController") as! OfferMainController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
        
        
    }
    
    
    func loadMainOffer(){
        
        
        
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("OfferMainController") as! OfferMainController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
        UserModel.setUserLoggedIn(false)
        UserModel.setConnectedFromFb(false);
        UserModel.saveUserDealCount(0);
    }
    
}
