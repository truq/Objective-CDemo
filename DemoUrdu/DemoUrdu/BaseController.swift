//
//  BaseController.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 9/28/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class BaseController: UIViewController{
    
        var isKeyboardAppear : Bool = false
        var navTitlelabel : UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeStatsBar()
        addLeftButton()
        navigationBarApperence()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationBarApperence(){
        // Colorize Navigation BackGround
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        
        
    }
    
    func customizeStatsBar(){
        
        //MARK : - Change Status Bar Color on Every Screen
        
        let view = UIView(frame: CGRect(x: 0.0, y: -20, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        view.backgroundColor=UIColor.redColor()
        self.navigationController?.navigationBar.addSubview(view)
        self.navigationController?.navigationBar.hidden = false
        
    }
    
    func setNavigationHidden(visibility: Bool){
        
        // MARK : - Set Navigation bar Visibility
        
        self.navigationController?.navigationBar.hidden = visibility
        
    }
    
    func addLeftButton(){
        
        let view = UIView(frame: CGRectMake(0, 0, 260, 40))
        let leftButton = UIButton(frame: CGRectMake(0, view.center.y, 30, 40))
        leftButton.center.y = view.center.y
        leftButton.setImage(UIImage(named: "menu_button.png"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: #selector(BaseController.didTapOnLeftButton), forControlEvents: UIControlEvents.TouchUpInside)
        navTitlelabel = UILabel(frame: CGRectMake(40, 0, 210, 40))
        navTitlelabel.center.y = view.center.y
        navTitlelabel.text = "Browse Organization"
        navTitlelabel.textAlignment = NSTextAlignment.Left
        navTitlelabel.textColor = UIColor.whiteColor()
        navTitlelabel.font = UIFont(name:"Arial", size: 17.0)
        navTitlelabel.adjustsFontSizeToFitWidth = true
        navTitlelabel.minimumScaleFactor = 0.5
        view.addSubview(leftButton)
        view.addSubview(navTitlelabel)
        let barButton = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightButton(){
        
        
        let button = UIButton(frame: CGRectMake(0, view.center.y, 20, 20))
        button.setImage(UIImage(named: "back-arrow.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(BaseController.didTapOnRightButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func pushViewController(destinationController:String){
        
        // Common Method to Push Controller in Navigation Controlller
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        print(destinationController, terminator: "")
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier(destinationController)
       self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func didTapOnLeftButton(){
        
        // MARK : - Show or Hide Side Menu
        toggleSideMenuView()
        
    }
    func didTapOnRightButton(){
        
        
        print("tap On Right", terminator: "")
        
        self.navigationController?.popViewControllerAnimated(true)

        

    }
    
    
    func setImageOnTextField(imageName : String , textField : UITextField){
        /*
        * MARK : Customize TextField
        * set image On right 
        * set padding Space On Left Side
        */
        
        let imageView = UIImageView();
        let image = UIImage(named:imageName);
        imageView.image = image;
        imageView.frame = CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(20), SizeUtil.convertIphone6ToIphone5(20));
        
        let paddingView = UIView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(30), SizeUtil.convertIphone6ToIphone5(20)))
        paddingView.addSubview(imageView)
        
        textField.rightView = paddingView
        textField.rightViewMode = UITextFieldViewMode.Always
        
        let leftPaddingView = UIView(frame: CGRectMake(0, 0,SizeUtil.convertIphone6ToIphone5(10), SizeUtil.convertIphone6ToIphone5(20)))
        textField.leftView = leftPaddingView
        textField.leftViewMode = UITextFieldViewMode.Always
        
    }
    
    // MARK : make keyboard observer 
    
    func addKeyboardObserver(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
    }
    
    func keyboardWillShow(sender: NSNotification){
        
        var info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if (isKeyboardAppear == false){
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.view.center.y = self.view.center.y - keyboardFrame.size.height
        })
            isKeyboardAppear = true
        }
        
    }
    func keyboardWillHide(sender: NSNotification){
        
        var info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if (isKeyboardAppear == true ){
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.center.y = self.view.center.y + keyboardFrame.size.height
        })
           isKeyboardAppear = false
        }
    }
    
    /// end 
    

}
