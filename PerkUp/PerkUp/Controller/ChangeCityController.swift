//
//  ChangeCityController.swift
//  PerkUp
//
//  Created by NGI-Noman on 30/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class ChangeCityController: BaseController,ChangeCityTableDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    var _cityArray : NSArray = NSArray()
    var _isRadioChecked = false
    var _previousSelectedIndex : Int!
    var _previousSelectedCell : UITableViewCell!
    
    var rightButton : UIButton!
    var arrayCity = ["Karachi","Islamabad","Rawalpindi","Lahore"]
    
    
    
    @IBOutlet var cityAlertView: UIView!
    
    
    @IBOutlet weak var tableAlertView: UITableView!
    @IBOutlet weak var alertBackgroundView: UIView!
    
    @IBOutlet weak var btnAlertView: UIButton!
    @IBOutlet weak var changeCityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
     self.createAlertCityTable()
        
        addRightButton();
        addLeftButton();
        
        
      //  self.fetchCityList();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func addLeftButton() {
        
        let lefttButton = UIButton(frame: CGRectMake(0, view.center.y, 110, 40))
        lefttButton.center.y = view.center.y
        lefttButton.setImage(UIImage(named: "backarrow"), forState: UIControlState.Normal)
        lefttButton.setTitle("Select City", forState: UIControlState.Normal);
        lefttButton.titleLabel?.font = UIFont(name:Constant.AppFontBold, size: SizeUtil.convertIphone6ToIphone5(15));
        lefttButton.addTarget(self, action: #selector(ChangeCityController.didTapOnLeftButton), forControlEvents: UIControlEvents.TouchUpInside);
        
        let spacing :CGFloat = 10; // the amount of spacing to appear between image and title
        lefttButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        lefttButton.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        
        let barButton = UIBarButtonItem(customView: lefttButton)
        
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    override func addRightButton() {
        
        rightButton = UIButton(frame: CGRectMake(0, view.center.y, 140, 40))
        rightButton.center.y = view.center.y
        rightButton.setImage(UIImage(named: "dropdown"), forState: UIControlState.Normal)
        rightButton.setTitle("Done", forState: UIControlState.Normal);
        rightButton.titleLabel?.font = UIFont(name:Constant.AppFontBold, size: SizeUtil.convertIphone6ToIphone5(15));
        rightButton.addTarget(self, action: #selector(ChangeCityController.didTapOnRightButton), forControlEvents: UIControlEvents.TouchUpInside);
        rightButton.titleLabel!.textAlignment = .Right
        
        rightButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        rightButton.titleLabel!.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        rightButton.imageView!.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
        let spacing :CGFloat = 5; // the amount of spacing to appear between image and title
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, spacing);
        rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        let barButton = UIBarButtonItem(customView: rightButton)
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        negativeSpace.width = -15
        self.navigationItem.rightBarButtonItems = [negativeSpace, barButton /* this will be the button which you actually need */]
        
    //   self.navigationItem.rightBarButtonItem = barButton
        
    }
    func didTapOnLeftButton(){
        
    }
    
    override func didTapOnRightButton(){
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            //
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(46)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return _cityArray.count
        return arrayCity.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "ChangeCityCell\(indexPath.row)"
        var cell:ChangeCityTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? ChangeCityTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("ChangeCityTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? ChangeCityTableCell
        }
         // changing for static code for
        //cell!.lblName.text = _cityArray[indexPath.row].objectForKey("city_name") as? String;
        if indexPath.row == 0{
            
        
        }else{
            cell?.lblcomingSoon.hidden = false
            cell?.btnRadio.hidden = true
        
        }
        
        cell?.lblName.text = arrayCity[indexPath.row]
        cell!.btnRadio.tag = indexPath.row + 1
        
        cell!.tag = cell!.btnRadio.tag
        cell!.selectionStyle = .None
        cell!._customDelegate = self
        
        if _previousSelectedIndex != nil && _previousSelectedIndex == indexPath.row + 1{
            cell!.btnRadio.selected = true
        }
        return cell!
        
    }

    
    func didTapOnRadioButton(sender: UIButton) {
        
        if let cell = changeCityTableView.viewWithTag(sender.tag) as? ChangeCityTableCell{
//            rightButton.setTitle(cell.lblName.text, forState: UIControlState.Normal);
            UserModel.saveUserCityName(cell.lblName.text!);
            UserModel.setUserHasCity(true)
            print(cell.tag)
            self.dismissViewControllerAnimated(true) { () -> Void in
                //
            }
        }
        
        print("clicked on radio button")
        
        
        if _previousSelectedIndex != nil{
            
            if let cell = changeCityTableView.viewWithTag(_previousSelectedIndex) as? ChangeCityTableCell{
                cell.btnRadio.selected = false;
            }
        }
 
        self._previousSelectedIndex = sender.tag

        
    }
    
    func fetchCityList(){
        
//        Alert.showLoader("");
        
        ServiceWrapper.getCityList { (success, response) -> Void in
            
            Alert.hideLoader()
            
            if (success){
                
                if let cityList = response.objectForKey("city") as? NSArray{
                    
                    self._cityArray = cityList
                    self.changeCityTableView.reloadData();
                    
                    
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        
        
    }
    
    @IBAction func closeTableAlert(sender: AnyObject) {
        
           UserModel.saveUserCityName("Karachi");

            
        
        
        
            if UserModel.getUserCityName() != ""{
                print("User city is not empty")
                
            }else{
                // when user did not select any city
                UserModel.saveUserCityName("Karachi");
                UserModel.setUserHasCity(false)
            }

            
        
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            //
        }

        
    }
    
    
    
    func createAlertCityTable(){
    
        cityAlertView.frame = CGRectMake(0,0, self.view.frame.size.width,self.view.frame.height)
        
        cityAlertView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(cityAlertView)
        self.cityAlertView.hidden = false
        

    
    }

}
