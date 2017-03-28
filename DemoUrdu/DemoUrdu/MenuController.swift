//
//  MenuController.swift
//  SlideViewDemo
//
//  Created by NGI-NOMAN on 9/29/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit



class MenuController : UITableViewController {
    
    @IBOutlet var menuTableView: UITableView!
    
    var _mainMenu = MenuService.sharedInstance.getMainMenu()
    var _menu : Menu!


    var cellIdentifier : String = "MenuCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Register custom cell
        let nib = UINib(nibName: "MenuTableCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier:cellIdentifier)
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
       // tableView.scrollsToTop = false
        tableView.scrollEnabled = false
        tableView.rowHeight=SizeUtil.convertIphone6ToIphone5(45)
        tableView.backgroundColor=UIColor.whiteColor()
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuController.refreshView), name: "MyNotification", object: nil)
        
        
    }
    
    func refreshView(){
        _mainMenu = MenuService.sharedInstance.getMainMenu()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - MenuTableView Delegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return SizeUtil.convertIphone6ToIphone5(140)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // MARK : - Table Header View
        let headerView = UIView(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(200), SizeUtil.convertIphone6ToIphone5(140)))
        headerView.backgroundColor = UIColor(red: 87/255, green: 125/255, blue: 172/255, alpha: 0.9)
        // MARK : - USER Image On Table View Header
        let userImage=UIImageView(frame: CGRectMake(headerView.center.x/2, headerView.center.y*0.15, SizeUtil.convertIphone6ToIphone5(100), SizeUtil.convertIphone6ToIphone5(100)))
        userImage.layer.borderWidth = 2
        userImage.layer.cornerRadius = userImage.bounds.width/2
        userImage.layer.masksToBounds = true
        userImage.layer.borderColor=UIColor.whiteColor().CGColor
        userImage.image = UIImage(named: "image_temp.png")
        headerView.addSubview(userImage)
        
        // MARK : - USER Name On Table View Header
        let userNameLabel = UILabel()
        userNameLabel.text = "Guest"
        
//        if UserModel.isUserLoggedIn(){
//            if !StringUtil.isEmptyOrNull(UserModel.getUserName()){
//                userNameLabel.text = UserModel.getUserName()
//            }
//
//        }
      
        userNameLabel.frame=CGRectMake(userImage.center.x/2, userImage.center.y + userImage.frame.size.height*0.50, SizeUtil.convertIphone6ToIphone5(100), SizeUtil.convertIphone6ToIphone5(20))
        userNameLabel.textColor=UIColor.whiteColor()
        userNameLabel.textAlignment=NSTextAlignment.Center
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.minimumScaleFactor=0.5;
        userNameLabel.font = UIFont(name: "HelveticaNeue", size: SizeUtil.convertIphone6ToIphone5(17))

        headerView.addSubview(userNameLabel)

        return headerView
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _mainMenu.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   override
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return menuCellAtIndexPath(indexPath)
    }
    
    func menuCellAtIndexPath(indexPath:NSIndexPath) -> MenuTableCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MenuTableCell
        setCellData(cell,indexPath : indexPath)
        return cell
    }
    func setCellData(tableCell:MenuTableCell,indexPath:NSIndexPath){
        
        _menu = _mainMenu.objectAtIndex(indexPath.row) as! Menu
        tableCell.menuNameLabel.text = _menu.name
        tableCell.menuIcon.image = UIImage(named: _menu.imageUrl)
        tableCell.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    print("did select row: \(indexPath.row)", terminator: "")
//        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
//        var destViewController : UIViewController
//        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.LOGIN_IDENTIFIER)
//    
//        if !UserModel.isUserLoggedIn(){
//       sideMenuController()?.setContentViewController(destViewController)
//            return
//        }
//    
    //Present new view controller

    switch (indexPath.row) {
    case 0:
//    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.MAIN_IDENTIFIER)
//           sideMenuController()?.setContentViewController(destViewController)
    break
    case 1:
//    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.HISTORY_IDENTIFIER)
//           sideMenuController()?.setContentViewController(destViewController)
    break
    case 2:
//    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.SETTINGS_IDENTIFIER)
//           sideMenuController()?.setContentViewController(destViewController)
    break
    case 3:
//    destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.PAYMENTINFO_IDENTIFIER)
//           sideMenuController()?.setContentViewController(destViewController)
        break
    case 4:
//        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MailController")
//        sideMenuController()?.setContentViewController(destViewController)
//        HelperUtil.mailTo(Constant.supportUrlString)
        break
    case 5:
//         HelperUtil.openUrl(Constant.organizationSignUpUrl)
        break
    case 6:
//         HelperUtil.openUrl(Constant.aboutUsUrlString)
        break
    case 7:
//        if UserModel.isUserLoggedIn(){
//            showPopUpForLogOut()
//        }else{
//        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.LOGIN_IDENTIFIER)
//        sideMenuController()?.setContentViewController(destViewController)
//        }
    break
    default:
    break
    }

 }
    
    func showPopUpForLogOut(){
        
        let alertController = UIAlertController(title: "", message: "Do you want to Logout.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "NO", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "YES", style: .Destructive) { (action) in
            
            self.logOutUser()
            
            print(action)
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
        }
        
    }
    
    func logOutUser(){
//         
//        UserModel.setUserLoginState(false)
//        UserModel.setUserHasCard(false)
        HelperUtil.setLastOrg(false)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
//        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier(Constant.MAIN_IDENTIFIER)
        dispatch_async(dispatch_get_main_queue(),{
            
            Alert.showToast("Log Out Successfully")
//          Alert.showAlert("", message: "Log Out Successfully.")
            
        })
//        sideMenuController()?.setContentViewController(destViewController)
      
    }

    
}
