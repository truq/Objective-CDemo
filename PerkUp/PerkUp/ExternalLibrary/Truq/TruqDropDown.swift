//
//  TruqDropDown.swift
//  PerkUp
//
//  Created by NGI-Noman on 31/03/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

public protocol TruqDropDownDelegate{
    
    func setTitleLabel();
}

class TruqDropDown: UIView,UITableViewDataSource,UITableViewDelegate {

    var _animationDirection : String!
    var _titleText : String!
    var imgView : UIImageView!
    var _titleArray : NSArray!
    
    var customDelegate : TruqDropDownDelegate?
    
    var btnSender : UIButton!
    var table : UITableView!
    var textView : UITextView!

    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    func showDropDown(button:UIButton,height:CGFloat,textArray:NSArray,direction:String) -> AnyObject?{
        
        btnSender = button;
        _animationDirection = direction;

        let buttonFrame : CGRect = button.frame;
        
        _titleArray = textArray
        if direction == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.width, 0)

            
        }
        else if direction == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, 0)

        }
            
            self.layer.masksToBounds = false;
            self.layer.cornerRadius = 5;
            self.layer.shadowRadius = 5;
            self.layer.shadowOpacity = 0.5;
        
            table = UITableView(frame: CGRectMake(0, 0,buttonFrame.size.width, 0))
            table.delegate = self;
            table.dataSource = self;
            table.layer.cornerRadius = 5;
            table.backgroundColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
            table.separatorStyle = .None
            table.separatorColor = UIColor.grayColor()
            table.bounces = false
            table.layer.borderColor = UIColor.blackColor().CGColor;
            table.layer.borderWidth = 1
            
        
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDelay(0.5);
        if direction == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y - height, buttonFrame.width, height)
            
        }
        else if direction == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, height)
        }
        
        table.frame = CGRectMake(0, 0, buttonFrame.size.width, height);
        table.separatorInset = UIEdgeInsetsZero
        UIView.commitAnimations();
        button.superview?.insertSubview(self, belowSubview: button);
        self.addSubview(table)
    
        return self
        
    }
    func hideDropDown(button:UIButton){
        
       let buttonFrame : CGRect = button.frame;
        
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDelay(0.5);
        if _animationDirection == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.width, 0)
            
        }
        else if _animationDirection == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, 0)
        }
        
        table.frame = CGRectMake(0, 0, buttonFrame.size.width, 0);
        UIView.commitAnimations();

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(40)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _titleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let CellIdentifier = "Cell";
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier);
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier);
            cell?.textLabel?.font = UIFont(name: Constant.AppFontRegular, size: 15);
            cell?.textLabel?.textAlignment = NSTextAlignment.Center
            
        }
        cell?.textLabel?.text = _titleArray[indexPath.row] as? String;
        cell?.textLabel?.textColor = UIColor.blackColor();
        cell?.separatorInset = UIEdgeInsetsZero
        return cell!;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        hideDropDown(btnSender);
        
        let cell = tableView.cellForRowAtIndexPath(indexPath);
        btnSender.setTitle(cell?.textLabel?.text, forState: UIControlState.Normal)
        customDelegate?.setTitleLabel();
    }
    
    
    
    
    func showDropDownWithTextView(button:UIButton,height:CGFloat,textString:String,direction:String) -> AnyObject?{
        
        btnSender = button;
        _animationDirection = direction;
        
        let buttonFrame : CGRect = button.frame;
        
        if direction == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.width, 0)
            
            
        }
        else if direction == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, 0)
            
        }
        
        self.layer.masksToBounds = false;
        self.layer.cornerRadius = 5;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        textView = UITextView(frame: CGRectMake(0, 0,buttonFrame.size.width, 0))
        textView.font = UIFont(name: Constant.AppFontRegular, size: 11);
        
        let htmlString : NSString = textString as NSString;
        print(htmlString);
        let attrStr = try! NSAttributedString(
            data: htmlString.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        
        textView.attributedText = attrStr
        textView.editable = false
        
        
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDelay(0.3);
        if direction == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y - height, buttonFrame.width, height)
            
        }
        else if direction == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, height)
        }
        
        textView.frame = CGRectMake(0, 0, buttonFrame.size.width, height);
        UIView.commitAnimations();
        button.superview?.insertSubview(self, belowSubview: button);
        self.addSubview(textView)
        
        return self
        
    }
    func hideDropDownTextView(button:UIButton){
        
        let buttonFrame : CGRect = button.frame;
        
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationDelay(0.3);
        if _animationDirection == "up"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y, buttonFrame.width, 0)
            
        }
        else if _animationDirection == "down"{
            
            self.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y + buttonFrame.size.height, buttonFrame.width, 0)
        }
        
        textView.frame = CGRectMake(0, 0, buttonFrame.size.width, 0);
        UIView.commitAnimations();
    
        
    }
    
    
}

