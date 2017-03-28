//
//  CheckNumberViewController.swift
//  PerkUp
//
//  Modified by NGI-Noman on 15/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit

// Constant values
let CLIENT_ID = "8P6o5WG2wa1md8mS"
let CLIENT_SECRET = "z0i87uYVZ6oxOLiX5a1u8Lqc2u8JfdLt"
let CLIENT_TYPE = "phone"

class CheckNumberViewController: UIViewController,UITextFieldDelegate {
    var window: UIWindow?
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblNumberIdentifier: UILabel!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var btnShowReward: UIButton!
    @IBOutlet weak var btnNotReceivedCode: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    
    
    @IBOutlet weak var lblVerifTopConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Devices.DeviceType.IS_IPHONE_4_OR_LESS{
          
             lblVerifTopConstraints.constant = -80
        }else if Devices.DeviceType.IS_IPHONE_5{
             lblVerifTopConstraints.constant = -50
        
        }
        
        
        
         createUI()
        addTapGestureDetector()

    }
    
    @IBAction func didTapOnShowReward(sender: AnyObject) {
        
        if !isAllRequiedField(){
            return
        }
        self.verifyPinCode(self.txtPinCode.text!,isComeFromGolbal: false)
    }
    
    @IBAction func didTapOnNotReceiveCode(sender: AnyObject) {
        
            self.resentPinCode()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func verifyPinCode(pinCode: String,isComeFromGolbal:Bool){
        
        // make the dictionary
        let dict = ["grant_type": "password",
            "client_id":CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "username":UserModel.getUserPhoneNumber(),
            "password":pinCode,
            "u_type":CLIENT_TYPE]
        
        NSLog("%@", dict);
        ServiceWrapper.accessToken(dict) { (success, response) -> Void in
            
            if ( success ) {
                
                NSLog("response = %@", response);
                
                // Default Preferences
                
                UserModel.setUserToken(response.objectForKey("access_token") as! String)
                UserModel.setTokenForRefresh(response.objectForKey("refresh_token") as! String)
                
                let expireTime = Int(response.objectForKey("expires_in") as! NSNumber);
                let timeInterval = expireTime/10000;
                
                print(timeInterval);
                //                UserModel.setExpiredTimeOfToken(response.objectForKey("expires_in") as! String)
                UserModel.setUserPin(pinCode)
                self.fetchUserDetail(pinCode,isComeFromGolbal: isComeFromGolbal)
                
            }
            else{
                Alert.showAlert("", message:"code invalid")
            }
        }
        
    }
    
    func fetchUserDetail(pinCode: String,isComeFromGolbal:Bool){
        
        // Make key value for service call
        let dict = [
            "username":UserModel.getUserPhoneNumber(),
            "password": pinCode,
            "u_type": "phone",
            "access_token":UserModel.getUserToken(),
            //"device_id":UserModel.getUserDeviceToken()
            "":"" ];
        ServiceWrapper.userProfile(dict) { (success, response) -> Void in
            
            if (success) {
                
                
                let dataDict = response.objectForKey("obj") as! NSDictionary
                
                UserModel.setUserName(dataDict.objectForKey("name") as! String)
                UserModel.setUserSessionKey(dataDict.objectForKey("session_key") as! String)
                print("user session key :",UserModel.getUserSessionKey())
                
                
                UserModel.setUserJoinDate(dataDict.objectForKey("user_since") as! String)
                UserModel.setUserLoggedIn(true);
                UserModel.setUserId(dataDict.objectForKey("id") as! String);
                
                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName(Constant.updateSideMenu, object: nil)
                })
                
                // Move to new screen
                if !isComeFromGolbal{
                    self.createMenuView();
                }
                else{
//                    AppDelegate.getInstatnce().invokeOnSuccess()
                
                    AppDelegate.getInstatnce().removeAlertView();
                    
                    
                }
                
                

                
            }
        }

        
    }
    
    
    func createUI(){
        
        
        
        lblNumberIdentifier.text = UserModel.getUserPhoneNumber()
        slideMenuController()?.removeLeftGestures()
        txtPinCode.layer.borderWidth = 0.5;
        txtPinCode.layer.borderColor = UIColor.whiteColor().CGColor;
        txtPinCode.layer.cornerRadius = Constant.CommonRadius;
        let paddingView = UIView(frame:CGRectMake(0, 0, 5, 5))
        txtPinCode.leftView = paddingView;
        txtPinCode.leftViewMode = UITextFieldViewMode.Always
        txtPinCode!.returnKeyType = UIReturnKeyType.Done
        
        btnShowReward!.layer.cornerRadius = Constant.CommonRadius;
        btnNotReceivedCode!.layer.cornerRadius = Constant.CommonRadius;
        btnOk.layer.cornerRadius = Constant.CommonRadius
        alertView.backgroundColor = UIColor.alertBGColor()
        btnSkip.layer.cornerRadius = Constant.CommonRadius;
        btnSkip.backgroundColor = UIColor.perkupOrange()
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    
    private func createMenuView() {
        
        let obj = MenuService()
            obj.getMainMenu()
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("MyRetailersViewController") as! MyRetailersViewController
        self.navigationController?.pushViewController(mainViewController, animated: true)
        
    }
    
    @IBAction func didTapOnCrossBtn(sender: AnyObject) {
        
            self.alertView.hidden = true
    }
    
    @IBAction func didTapOnOkBtn(sender: AnyObject) {
        
            self.alertView.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        txtPinCode.resignFirstResponder()
        lblNumberIdentifier.text = txtPinCode.text
        return true
    }
    func isAllRequiedField()->Bool{
        
        if StringUtil.isEmptyOrNull((self.txtPinCode?.text)!){
            Alert.showAlert("", message: "text field should not be empty");
            return false;
        }
        
        return true;
        
    }
    
    func resentPinCode(){
        
        
        let dict = ["phone_number": (self.lblNumberIdentifier?.text)!]
        
        ServiceWrapper.sendCode(dict) { (success, response) -> Void in
            if (success) {
                NSLog("%@", response)
                self.alertView.hidden = false
                
            } else {
                
                NSLog("%@", response);
                // Call the Api for sign up
                Alert.showAlert("", message: "Network Problem");
            }
        }
    }
    func addTapGestureDetector(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckNumberViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        //Calls this function when the tap is recognized.
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    
    
    @IBAction func didTapOnSkip(sender: AnyObject) {
        
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("OfferMainController") as! OfferMainController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
        
    }
    
    @IBAction func didTapOnBack(sender: AnyObject) {
        
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("AuthController") as! AuthController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
        print("Welcome")
    }
    
    
}
