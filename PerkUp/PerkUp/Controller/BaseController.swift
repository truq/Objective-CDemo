//
//  BaseController.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 9/28/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
        var _isKeyboardAppear : Bool = false
        var _navTitlelabel : UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeStatsBar()
        self.navigationBarApperence();
        addLeftNavigationButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationBarApperence(){
        
        // Colorize Navigation BackGround
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 2/255, green: 136/255, blue: 209/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func setNavigationTitleText(title:String){
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: UIFont(name:Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(17))!];
        self.navigationItem.title = title;
        
    }
    
    func customizeStatsBar(){
        
        //MARK : - Change Status Bar Color on Every Screen
        let view = UIView(frame: CGRect(x: 0.0, y: -20, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        self.navigationController?.navigationBar.addSubview(view)
        self.navigationController?.navigationBar.hidden = false
        
    }
    
    func addRightButton(){
        
        
        let button = UIButton(frame: CGRectMake(0, view.center.y, 20, 20))
        button.setImage(UIImage(named: "notification"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(self.didTapOnRightButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    func didTapOnRightButton() {
        //
    }
    
    func addLeftButton() {
        
        let button = UIButton(frame: CGRectMake(0, view.center.y, 10, 16))
        button.setImage(UIImage(named: "backarrow"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(BaseController.backToPreviousView), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton;
    }
    
    func backToPreviousView(){
        
        self.navigationController!.popViewControllerAnimated(true)
        
    }
    
    // MARK : make keyboard observer 
    
    func addKeyboardObserver(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    func keyboardWillShow(sender: NSNotification){
        
        var info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if (_isKeyboardAppear == false){
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.view.center.y = self.view.center.y - keyboardFrame.size.height
        })
            _isKeyboardAppear = true
        }
        
    }
    func keyboardWillHide(sender: NSNotification){
        
        var info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if (_isKeyboardAppear == true ){
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.center.y = self.view.center.y + keyboardFrame.size.height
        })
           _isKeyboardAppear = false
        }
    }
    
    /// end 
    
    func addTapGestureDetector(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseController.DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        //Calls this function when the tap is recognized.
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    

}
