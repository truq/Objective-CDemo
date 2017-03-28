//
//  AppDelegate.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 25/02/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit
import FBSDKShareKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,PerkupAlertViewDelegate {

    var window: UIWindow?
    var backgroundTransferCompletionHandler: (() -> Void)?
    var alertView : PerkupAlertView!
    var _phoneNumber = ""
    var _email = ""
    var _isPhoneNumberValid = true
    var _pinCode = ""


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UserModel.setControllerName(" ");
        self.createMenuView();
        askPermissionForPushNotification();
        return true
    }
    
    func application(application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: () -> Void) {
        backgroundTransferCompletionHandler = completionHandler
        NSLog("handle event for background session")
    }
    
    //Mark : faceboook url handler
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
        
               let urlHandler = FBSDKApplicationDelegate.sharedInstance().application(
                    application,
                    openURL: url,
                    sourceApplication: sourceApplication,
                    annotation: annotation)
                //Facebook callback
            return urlHandler
            
    }
    //Mark: pushnotification delegate
    //MArk: Register Device
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("DEVICE TOKEN = \(deviceToken)")
        
        var token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"));
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "");
        
        let dict = ["device_id":token,
                    "device_type":"ios"];
        
        if !UserModel.isDeviceTokenRegisterd() {
            registerDeviceOnServer(dict);
            
        }
        UserModel.setUserDeviceToken(token);
        
    }
    //MArk show Error if Device Not Register
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    //Mark: Pushnotification listner
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
        
    }
    //MArk: end Delegate for push notification

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func askPermissionForPushNotification() {
        if #available(iOS 8.0, *) {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        } else {
            let settings = UIRemoteNotificationType.Alert.union(UIRemoteNotificationType.Badge).union(UIRemoteNotificationType.Sound)
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(settings)
        }
    }
    
    // CREATE THE MENU VIEW LOAD ANOTHER STORY BOARD
    private func createMenuView() {
        
        //Noman Modified
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var mainViewController : UIViewController!
        
        if ( UserModel.isUserLoggedIn() ){
          
            
            mainViewController = storyboard.instantiateViewControllerWithIdentifier("MyRetailersViewController") as! MyRetailersViewController
        }
        else{
            mainViewController = storyboard.instantiateViewControllerWithIdentifier("AuthController") as! AuthController
        }
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("MenuController") as! MenuController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController )
        
        self.window?.rootViewController = slideMenuController;
        self.window?.makeKeyAndVisible()
        
    }
    static func getInstatnce() -> AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    
    func createAlertView(){
        
        alertView = PerkupAlertView(frame:(AppDelegate.getInstatnce().window?.bounds)!)
        alertView.customDelegate = self
        AppDelegate.getInstatnce().window?.rootViewController!.view.addSubview(alertView);
        
    }
    
    //MARK:alertView Delegate
    func removeAlertView() {
        
        alertView.removeFromSuperview()
        _isPhoneNumberValid = true
        _phoneNumber = ""
        _email = ""
        _pinCode = ""
        
       let didTapOnCart =  NSUserDefaults.standardUserDefaults().boolForKey("tapOnCart")
        
        if didTapOnCart{
            if UserModel.isUserLoggedIn(){
            self.loadBookedOffer()
            }
        }
        
        
       // gaurd let controller =
        
        print(UserModel.getControllerName())
        
        
        let controller = UserModel.getControllerName()
        
        if controller != "" {
        
            if controller == "saved" {
                UserModel.setControllerName(" ")

                 loadSaved()
            
            }else if controller == "myPerkup"{
                   UserModel.setControllerName(" ")
                loadProfile()
            }
            
            
            
        }
        
    }
    func registerUser(sender: AnyObject) {
        
        alertView.endEditing(true)
        
        if sender.tag == 2{
            let checkNumbercontroller = CheckNumberViewController()
            checkNumbercontroller.verifyPinCode(_pinCode, isComeFromGolbal: true)
            return
        }
        
        if _isPhoneNumberValid{
           loginUserViaNumber()
            return
        }
        registerNewUser()

    }
    
    func setTextFieldData(dataStr: String, tagValue: Int) {
        
        // Profile View Text field data set, detection by tag value
        // 0 for current password field
        // 1 for new password field
        
        if tagValue == 0{
            self._phoneNumber = dataStr
        }
        else if tagValue == 2{
            self._pinCode = dataStr
        }
        else{
            self._email = dataStr
        }
        
    }
    func loginUserViaNumber(){
        
        print(self._phoneNumber);
        
        if !alertView.isPhoneNumberValid(self._phoneNumber){
            //removeAlertView()
            return
        }
        
        let dict = ["phone_number": self._phoneNumber]
        
        ServiceWrapper.sendCode(dict) { (success, response) -> Void in
            if (success) {
                
                
                NSLog("%@", response);
                UserModel.setUserPhoneNumber(self._phoneNumber);
                
                self._isPhoneNumberValid = true
                self.alertView.txtMobileNumber.text = nil
                self.alertView.txtMobileNumber.tag = 2
                self.alertView.txtMobileNumber.placeholder = "Enter the activation code";
                self.alertView.txtMobileNumber.keyboardType = UIKeyboardType.NumberPad
                self.alertView.btnRegister.setTitle("Activate", forState: UIControlState.Normal)
                self.alertView.btnRegister.tag = 2
                self.alertView.lbldecription.text = "A code has been sent on your number"
                
                self.alertView.lblheader.text = "Confirm Yourself"
                
                
            }
            else {
                
                NSLog("%@", response);
                // Call the Api for sign up
                self._isPhoneNumberValid = false
                self.alertView.txtMobileNumber.text = nil
                self.alertView.txtMobileNumber.tag = 1
                self.alertView.txtMobileNumber.placeholder = "Enter Email Address";
                self.alertView.txtMobileNumber.keyboardType = UIKeyboardType.EmailAddress
                self.alertView.btnRegister.tag = 1
                self.alertView.btnRegister.setTitle("Next", forState: UIControlState.Normal)
                self.alertView.lbldecription.text = "To complete the registration process"
                self.alertView.lblheader.text = "Enter your Email Address"
                
                
            }
        }
        
    }
    ///
    
    func registerNewUser(){
        
        print(self._phoneNumber)
        print(self._email)
        
        // validate email
        if StringUtil.isEmptyOrNull(self._email){
            Alert.showAlert("", message: "text field should not be empty");
            
        }
        else if !StringUtil.isValidEmail(self._email) {
            Alert.showAlert("", message: "email is not valid");
            
        }else{
        
        let dict = ["phone_number":self._phoneNumber,
            "email":self._email]
        
        ServiceWrapper.signUp(dict) { (success, response) -> Void in
            if (success) {
                
                NSLog("%@", response);
                UserModel.setUserPhoneNumber(self._phoneNumber);
                UserModel.setUserEmail(self._email)
                self._isPhoneNumberValid = true
                self.loginUserViaNumber()
            }
            else {
                
                NSLog("%@", response);
                // Call the Api for sign up
                self._isPhoneNumberValid = true
                self.alertView.txtMobileNumber.text = nil
                self.alertView.txtMobileNumber.tag = 0
                self.alertView.txtMobileNumber.placeholder = "Enter Phone Number";
                self.alertView.txtMobileNumber.keyboardType = UIKeyboardType.NumberPad
                self.alertView.btnRegister.tag = 0
                self.alertView.btnRegister.setTitle("Register", forState: UIControlState.Normal)
                self.alertView.lbldecription.text = "Register at PerkUp"
                self.alertView.lblheader.text = "GET STARTED"
            }
        }
        }// end of else of email validate
    }
    func invokeOnSuccess(){
        
        self.alertView.viewOnRegComplete.hidden = false
        self.alertView.viewRegister.hidden = true
        self.alertView.btnCloseWhite.setImage(UIImage(named: "close-blue"), forState: UIControlState.Normal)
        
    }
    func performAction(sender: AnyObject) {
       
        self.removeAlertView()
    }
    
    func loadBookedOffer(){
        
        let _bookedOfferArray : NSMutableArray = NSMutableArray();
        
        
        print("user session key ",UserModel.getUserSessionKey())
        print("user session key ",UserModel.getUserToken())

        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["access_token":UserModel.getUserToken()]
        
        ServiceWrapper.getAllBookedOffer("\(Constant.baseUrlForSecure)booking",header: header, param: dict) { (success, response) -> Void in
            
            if (success){
                print("Success")
                print(response);
                
                if let dataArray = response.objectForKey("booking") as? NSArray{
                    
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        return
                    }
                    //Mark : adding items in array
                    for item in dataArray{
                        let booking = Booking()
                         booking.setDataFromServer(item as! NSDictionary)
                        _bookedOfferArray.addObject(booking);
                        
                    }
                    //Mark: reload Data
                       UserModel.saveUserDealCount(_bookedOfferArray.count);
                    
                }
                
                let isDidTapOnWhite = NSUserDefaults.standardUserDefaults().boolForKey("clickOnWhite")
                print("isDidTapOnWhite",isDidTapOnWhite)
                
                if isDidTapOnWhite{
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("clickOnWhite")
                }else{
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("clickOnWhite")
                    
                    if UserModel.getUserDealCount() <= 0 {
                        Alert.showAlert("Booked Deals", message: "You have no any booked Deal")
                    }else{
                        
                        Alert.showAlert("Booked Deals", message: "You have \(UserModel.getUserDealCount()) booked Deal")
                        
                    }
                    
                }
                
            }
                
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        
    }

    func loadSaved(){
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("SavedDetailController") as! SavedDetailController
        
        
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("MenuController") as! MenuController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController )

        self.window?.rootViewController = slideMenuController;
        self.window?.makeKeyAndVisible()

        
}
  
    func loadProfile(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileController") as! ProfileController
        
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("MenuController") as! MenuController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController )
        
        self.window?.rootViewController = slideMenuController;
        self.window?.makeKeyAndVisible()
        
    
    }
    
    func registerDeviceOnServer(dict: NSDictionary) {
        ServiceWrapper.registerDeviceOnServer(dict) { (success, response) in
            if(success){
                UserModel.setDeviceTokenRegisterd(true);
            }
        }
    }
    
}

