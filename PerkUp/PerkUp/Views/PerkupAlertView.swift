//
//  PerkupAlertView.swift
//  PerkUp
//
//  Created by NGI-Noman on 14/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit


@objc public protocol PerkupAlertViewDelegate{
    
     func removeAlertView();
     optional func registerUser(sender: AnyObject);
     optional func setTextFieldData(dataStr: String, tagValue: Int)
     optional func performAction(sender: AnyObject)

}

class PerkupAlertView: UIView,UITextFieldDelegate {
    
    @IBOutlet weak var viewRegister: UIView!
    @IBOutlet weak var headerRegView: UIView!
    @IBOutlet weak var lblheader: UILabel!
    @IBOutlet weak var lbldecription: UILabel!
    
    @IBOutlet weak var btnCloseWhite: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var lbl_info: UILabel!
    var customDelegate : PerkupAlertViewDelegate?
    
    @IBOutlet weak var viewOnRegComplete: UIView!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PerkupAlertView", bundle: bundle)
        let view =  nib.instantiateWithOwner(self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.backgroundColor = UIColor.alertBGColor()
        self.addSubview(view);
        
        customizeUIViews();
        
    }
    
    func customizeUIViews(){
        btnRegister.layer.cornerRadius = Constant.CommonRadius
        btnRegister.backgroundColor = UIColor.perkupGreen()
        btnContinue.layer.cornerRadius = Constant.CommonRadius
        btnContinue.backgroundColor = UIColor.perkupGreen()
        headerRegView.backgroundColor = UIColor.perkupBlue()
        viewOnRegComplete.hidden = true
        viewOnRegComplete.layer.cornerRadius = Constant.CommonRadius
        
    }
    
    @IBAction func didTapOnRegisterButton(sender: AnyObject) {
        
        customDelegate?.registerUser!(sender)
        
    }
    
    @IBAction func didTapOnWhiteClose(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
                       defaults.setBool(true, forKey:"clickOnWhite")
                       //adding 
                       UserModel.setControllerName(" ")

        
        customDelegate?.removeAlertView()
    }
    
    @IBAction func didTapOnContinue(sender: AnyObject) {
        
        customDelegate?.performAction!(sender)
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        print("start editing")
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("end editing")
        return true
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
        
        if updatedTextString.length > 11 && textField.tag == 0{
            Alert.showAlert("", message: "Number Not Valid")
           return false
        }
        if updatedTextString.length > 5 && textField.tag == 2{
            Alert.showAlert("", message: "Invalid Pin Code")
            return false
        }
        
        customDelegate?.setTextFieldData!(updatedTextString as String, tagValue: textField.tag)
        print("typing....")
        return true
    }
    
    func isPhoneNumberValid(number: String) -> Bool{
        
        if !StringUtil.isPhoneNumberValid(number) {
            Alert.showAlert("", message: "Number Not Valid")
            return false
        }
        return true
        
    }
    
    
    
}
