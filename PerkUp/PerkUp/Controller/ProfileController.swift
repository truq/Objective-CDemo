//
//  ProfileController.swift
//  PerkUp
//
//  Created by NGI-Noman on 01/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class ProfileController: BaseController,TruqDropDownDelegate {

    var _dropDown:TruqDropDown!
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var btnDropDown: UIButton!
    
    @IBOutlet weak var btnRegOrSave: UIButton!
    
    @IBOutlet weak var btnWidth: NSLayoutConstraint!
    var numberOFTimesBtnClick:Int = 0
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        let mobileNum = UserModel.getUserPhoneNumber()
        txtMobileNumber.attributedPlaceholder = NSAttributedString(string:mobileNum,
                                                                   attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        
        
        btnDropDown.setTitle(UserModel.getUserCityName(), forState: UIControlState.Normal)
       // btnRegOrSave.setTitle("EDIT", forState: UIControlState.Normal)

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        btnDropDown.layer.shadowOpacity = 0.5
//        btnDropDown.layer.shadowRadius = Constant.CommonRadius
//        btnDropDown.layer.cornerRadius = Constant.CommonRadius
//        btnDropDown.layer.shadowOffset =  CGSizeMake(0, 2);
        
//        addTapGestureDetector()
        
        // setting for app crash when user did not select city
        
        
        
        
        if !UserModel.isUserHasCity(){
            let changeCityController = storyboard!.instantiateViewControllerWithIdentifier("ChangeCityController") as! ChangeCityController
            self.navigationController?.presentViewController(changeCityController, animated: true, completion: { () -> Void in
                
                self.viewDidAppear(true)
            })
        }
        

        
        
        
        let mobileNum = UserModel.getUserPhoneNumber()
                        txtMobileNumber.attributedPlaceholder = NSAttributedString(string:mobileNum,
                                       attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
                

            
        
        
        
        
        
       // addRightButton()
        
        setProfileEditable(false);
        
        btnRegOrSave.layer.cornerRadius = Constant.CommonRadius
        
        btnDropDown.setTitle(UserModel.getUserCityName(), forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func addLeftButton() {
        
        let lefttButton = UIButton(frame: CGRectMake(0, view.center.y, 110, 40))
        lefttButton.center.y = view.center.y
        lefttButton.setImage(UIImage(named: "backarrow"), forState: UIControlState.Normal)
        lefttButton.setTitle("Profile", forState: UIControlState.Normal);
        lefttButton.titleLabel?.font = UIFont(name:Constant.AppFontBold, size: SizeUtil.convertIphone6ToIphone5(15));
        lefttButton.addTarget(self, action: #selector(ProfileController.didTapOnLeftButton), forControlEvents: UIControlEvents.TouchUpInside);
        
        let spacing :CGFloat = 10; // the amount of spacing to appear between image and title
        lefttButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        lefttButton.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        
        let barButton = UIBarButtonItem(customView: lefttButton)
        
        self.navigationItem.leftBarButtonItem = barButton
        
    }
//    
//    override func addRightButton() {
//        
//       let rightButton = UIButton(frame: CGRectMake(0, view.center.y, 40, 40))
//        rightButton.center.y = view.center.y
//        rightButton.setImage(UIImage(named: "edit-white"), forState: UIControlState.Normal)
//        rightButton.setImage(UIImage(named: "edit-grey"), forState: UIControlState.Selected)
//        rightButton.addTarget(self, action: #selector(ProfileController.didTapOnRightButton(_:)), forControlEvents: UIControlEvents.TouchUpInside);
//        rightButton.titleLabel!.textAlignment = .Right
//        
//        let barButton = UIBarButtonItem(customView: rightButton)
//           self.navigationItem.rightBarButtonItem = barButton
//        
//    }
    func didTapOnLeftButton(){
        
    }
    
//    func didTapOnRightButton(sender:UIButton){
//        
//        if sender.selected{
//            sender.selected = false
//            setProfileEditable(false);
//        }
//        else{
//            sender.selected = true
//            setProfileEditable(true);
//        }
//        
//    }
    
    func setProfileEditable(state:Bool){
        
        txtMobileNumber.userInteractionEnabled = false
        txtEmailAddress.userInteractionEnabled = false
        btnDropDown.userInteractionEnabled = state
        btnRegOrSave.userInteractionEnabled = true
        
    }
    
    @IBAction func didTapOnUpdateOrRegister(sender: AnyObject) {
        
        
        
        
        
        self.setProfileEditable(true)
        
        

        if numberOFTimesBtnClick % 2 == 0 {
        
                   print("First time")
            
            UIView.animateWithDuration(1.0, animations: {
                self.btnWidth.constant = 140
                self.btnRegOrSave.setTitle("SAVE CHANGES", forState: UIControlState.Normal)
                

                
            })
            
            
//            let changeCityController = storyboard!.instantiateViewControllerWithIdentifier("ChangeCityController") as! ChangeCityController
//            self.navigationController?.presentViewController(changeCityController, animated: true, completion: { () -> Void in
//                
//            })
//
            
            
            
        
        }else{
        
            UIView.animateWithDuration(1.0, animations: {
                self.btnWidth.constant = 120
                self.btnRegOrSave.setTitle("EDIT", forState: UIControlState.Normal)
                

            
            })
            
                  print("Second time")
            let header = ["sessionkey":UserModel.getUserSessionKey()]
            let dict = ["access_token":UserModel.getUserToken(),
                        "city":UserModel.getUserCityName()]
            print("user City Name:",UserModel.getUserCityName())
            
            
            ServiceWrapper.updateUserProfile("\(Constant.baseUrlForSecure)customer/\(UserModel.getUserId())", header: header, param: dict) { (success, response) -> Void in
                //
                if (success){
                    
                    print("",response);
                    Alert.showAlert("", message: "User Data Updated")
                    
                }
                    
                else{
                    Alert.showAlert("", message: "Network Problem")
                }
                
            }
            

            
            
        }// end of else
        
        
        numberOFTimesBtnClick += 1
        
    }
    
    @IBAction func didTapOnDropDown(sender: AnyObject) {
        
        
//        
//        print("yes tap on the dropdown")
//        
      
        let changeCityController = storyboard!.instantiateViewControllerWithIdentifier("ChangeCityController") as! ChangeCityController
        self.navigationController?.presentViewController(changeCityController, animated: true, completion: { () -> Void in
            
        })

        
        
        
       //5 btnRegOrSave.setTitle("SAVE CHANGES", forState: UIControlState.Normal)
        
        
//        let dropDownheight = self.view.frame.size.height - btnDropDown.frame.origin.y - btnDropDown.frame.size.height
//        
//        let cityArray = HelperUtil.loadDataFromPlist("cities").valueForKey("city") as! NSArray;
//        if(_dropDown == nil) {
//            _dropDown = TruqDropDown()
//            _dropDown.showDropDown(sender as! UIButton, height:dropDownheight , textArray: cityArray, direction: "down")
//            _dropDown.customDelegate = self
//        }
//        else {
//            _dropDown.hideDropDown(sender as! UIButton)
//            _dropDown = nil
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setTitleLabel() {
        ///
        UserModel.saveUserCityName((btnDropDown.titleLabel?.text)!);
    }

}
