//
//  AuthController.swift
//  PerkUp
//
//  Created by NGI-Noman on 10/03/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

class AuthController: UIViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var bottomArraowImage: NSLayoutConstraint!
       
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var emailViewTop: NSLayoutConstraint!
    @IBOutlet weak var lblEnterMobNo: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField?
    @IBOutlet weak var btnNext: UIButton?
    @IBOutlet weak var txtEmail: UITextField!
   
    
    @IBOutlet weak var imageRight: UIImageView!
    
    @IBOutlet weak var btnSkip: UIButton!
    var loginNewUser:Bool = false
    @IBOutlet weak var lblTop: NSLayoutConstraint!
  //  @IBOutlet weak var txtMobileNoTop: NSLayoutConstraint!

  //  @IBOutlet weak var emailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewEmail: UIView!
    
    var _isPhoneNumberValid = true
   
    
    
    
    
    override func viewWillAppear(animated:Bool) {
        
        self.showMobileView()
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if Devices.DeviceType.IS_IPHONE_5{
              lblTop.constant = 170
            
        }else if Devices.DeviceType.IS_IPHONE_6P{
        
        lblTop.constant = 256
        }else if Devices.DeviceType.IS_IPHONE_4_OR_LESS{
            lblTop.constant = 130
            bottomArraowImage.constant = -5

        }else{
            lblTop.constant = 225

        
        }
        
        
        
        createUI();
        addTapGestureDetector()
       // emailViewHeight.constant = 0
        self.showMobileView()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUI(){
        
        
        let attribute = [ NSForegroundColorAttributeName: UIColor.placeHolderColor(), NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 17.0)!]
        
        
        
        
        slideMenuController()?.removeLeftGestures()
        txtMobileNumber!.layer.borderWidth = 0.5;
        txtMobileNumber!.layer.borderColor = UIColor.whiteColor().CGColor;
        txtMobileNumber!.layer.cornerRadius = Constant.CommonRadius;
        let paddingView = UIView(frame:CGRectMake(0, 0, 5, 5))
        txtMobileNumber!.leftView = paddingView;
        
        txtMobileNumber!.attributedPlaceholder = NSAttributedString(string: "03XXXXXXXXX", attributes: attribute)
        
        txtMobileNumber!.leftViewMode = UITextFieldViewMode.Always
        txtMobileNumber!.returnKeyType = UIReturnKeyType.Done
        
        txtEmail.layer.borderWidth = 1// 0.5
        txtEmail.layer.borderColor = UIColor.whiteColor().CGColor
        txtEmail.layer.cornerRadius = Constant.CommonRadius
        
         txtEmail!.attributedPlaceholder = NSAttributedString(string: "Enter Your Email Address", attributes: attribute)
        btnNext!.layer.cornerRadius = Constant.CommonRadius;
        btnSkip.layer.cornerRadius = Constant.CommonRadius;
        btnSkip.backgroundColor = UIColor.perkupOrange()
        // Hide the navigation from here
        self.navigationController?.navigationBar.hidden = true
        
        
        
        
        

    }
    
    // Check the mobile number
    // if success move to another screen
    @IBAction func checkMobileNumber(sender: UIButton) {
        
        print("Register clicked",txtMobileNumber?.text)
        print("Email", txtEmail?.text)
        print(_isPhoneNumberValid)
          if _isPhoneNumberValid && txtEmail.text == ""
          {
            self.hideMobileView()
            loginUserViaNumber();
         }else
          
             {
        
                registerNewUser()
        
            }
        
    }
    
    
    func loginUserViaNumber(){
        
        if loginNewUser
        {
            print("login new user ",loginNewUser)
        }
        
        if !isAllRequiedField(){
            self.showMobileView()
            return
        }
        
       

        
        
        let dict = ["phone_number": (self.txtMobileNumber?.text)!,
                    "authkey" : "UJ73oZRvR86m"]
                   print("user location dictionary:\(dict)")
        let defaults = NSUserDefaults.standardUserDefaults()
                       defaults.setValue(dict, forKey:"mobileNum")
        
        print("send data for code Resquest ",dict)
        
        ServiceWrapper.sendCode(dict) { (success, response) -> Void in
            if (success) {
                
                
                UserModel.setUserPhoneNumber((self.txtMobileNumber?.text)!);
                self.changeViewController();
            }
            else {
                
                // if user new than this block execute
                NSLog("%@", response);
                self.hideMobileView()
                if Devices.DeviceType.IS_IPHONE_5{
                    self.lblEmail.font.fontWithSize(SizeUtil.convertIphone6ToIphone5(26))
                }

                // if issue on service side
              //  Alert.showAlert("Email ", message: response.objectForKey("message") as! String)
                
            }
        }
        
    }
    
    func registerNewUser(){
        
        loginNewUser = true
        emailViewTop.constant = SizeUtil.convertIphone6ToIphone5(140)
        if !isAllRequiedFieldForSignUp(){
            return
        }
        
        print("  Mobile No: \(self.txtMobileNumber?.text)")
        print(" Email : \(self.txtEmail?.text)")
        
        
        
        
        let dict = ["phone_number": (self.txtMobileNumber?.text)!,
            "email": (self.txtEmail?.text)!]
        
        ServiceWrapper.signUp(dict) {
            (success, response) -> Void in
            if (success) {
                
                NSLog("Response of SignUp: %@", response);
                UserModel.setUserPhoneNumber((self.txtMobileNumber?.text)!);
                UserModel.setUserEmail((self.txtEmail?.text)!)
                self._isPhoneNumberValid = true
                self.viewEmail.hidden = true
                
                self.changeViewController();
            }
            else {
                
                   NSLog("%@", response);
                   Alert.showAlert("Email Error ", message: response.objectForKey("message") as! String)
                
            
                }
            
           // Alert.showAlert("", message: response.objectForKey("message") as! String)
            
        }
        
    }  // end of func
    
    @IBAction func didTapOnSkipButton(sender: AnyObject) {
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("OfferMainController") as! OfferMainController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
        
    }

  //  SizeUtil.convertIphone6ToIphone5(13)
    func changeViewController(){
        
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("CheckNumberViewController") as! CheckNumberViewController
        let nvc: UIViewController = UINavigationController(rootViewController: mainViewController)
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        txtMobileNumber!.resignFirstResponder()
        return true
    }
    
    func isAllRequiedField()->Bool{
        
        if !StringUtil.isPhoneNumberValid((self.txtMobileNumber?.text)!) {
            Alert.showAlert("", message: "Phone Number is not valid");
            return false;
        }
        return true;
        
    }
    func isAllRequiedFieldForSignUp()->Bool{
        
        if !StringUtil.isPhoneNumberValid((self.txtMobileNumber?.text)!) {
            Alert.showAlert("", message: "Phone Number is not valid");
            return false;
        }
        if StringUtil.isEmptyOrNull((self.txtEmail?.text)!){
            
            print()
            Alert.showAlert("", message: "text field should not be empty");
            return false;
        }
        if !StringUtil.isValidEmail((self.txtEmail?.text)!) {
            Alert.showAlert("", message: "email is not valid");
            return false;
        }
        
        return true;
        
    }
    
    func addTapGestureDetector(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AuthController.DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        //Calls this function when the tap is recognized.
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    
    //Mark:textField Delegate 
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //
    }
    func textFieldDidEndEditing(textField: UITextField) {
        //
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if string == " " {
            return false
        }
        
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.stringByReplacingCharactersInRange(range, withString: string)
        
        if  textField == txtMobileNumber{
        }
        
        if updatedTextString.length > 11 && textField.tag == 0{
            Alert.showAlert("", message: "Number Not Valid")
            return false
        }
//        if updatedTextString.length > 5 && textField.tag == 2{
//            Alert.showAlert("", message: "Invalid Pin Code")
//            return false
//        }
//        
        
        return true
    }


    @IBAction func didTapOnBack(sender: AnyObject) {
        
        viewEmail.hidden = true
        
        btnNext?.setTitle("REGISTER", forState:UIControlState.Normal)
        imageRight.hidden = false
        lblDescription.hidden = false
        lblEnterMobNo.hidden =  false
        btnSkip.hidden = false
        txtMobileNumber?.hidden = false
        btnBack.hidden = true
        
        
        
        
        
        print("you click on back")
        
        
    }
    
    
    func hideMobileView(){
        
         // hide mobile view
          imageRight.hidden = true
          lblDescription.hidden = true
          lblEnterMobNo.hidden = true
          btnSkip.hidden = true
          btnNext?.setTitle("DONE", forState: UIControlState.Normal)
          txtMobileNumber?.hidden = true
        // show Email
        
          btnBack.hidden = false
          viewEmail.hidden = false
        
    
    
    }
    
    
    func showMobileView(){
    
        // show mobile view
        imageRight.hidden = false
        lblDescription.hidden = false
        lblEnterMobNo.hidden = false
        btnSkip.hidden = false
        btnNext?.setTitle("REGISTER", forState: UIControlState.Normal)
        txtMobileNumber?.hidden = false
        // hide Email
        
        btnBack.hidden = true
        self.viewEmail.hidden = true

    
    }
    
    


}