//
//  MenuController.swift
//  SlideViewDemo
//
//  Created by NGI-NOMAN on 9/29/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import UIKit



enum LeftMenu: Int {
    
    case BROWSE_OFFER = 0
    case SAVED_OFFER
    case MY_RETAILER
    case PERKUP
    case SETTING
    case LOGOUT
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class MenuController : UIViewController,LeftMenuProtocol,UITableViewDataSource,UITableViewDelegate {
    
    
    var isLogIn: Bool = Bool()
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblJoiningDate: UILabel!
    
    var _mainViewController: UIViewController!
    var _authViewController: UIViewController!
    var _browseOfferController : UIViewController!
    var _settingsController : UIViewController!
    var _profileController : UIViewController!
    var _savedOfferController :UIViewController!
    var userLogOut : Bool!
    @IBOutlet var menuTableView: UITableView!
    let objMenu = MenuService()

    var _mainMenu = MenuService.sharedInstance.getMainMenu()
    var _menu : Menu!

    var cellIdentifier : String = "MenuCell"
    
    
    override func viewWillAppear(animated: Bool) {
        
        if !UserModel.isUserLoggedIn(){
            UserModel.saveUserDealCount(0);

                menuTableView.reloadData()
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Register custom cell
        menuTableView.registerNib(HelperUtil.getViewFromNib("MenuTableCell"), forCellReuseIdentifier:cellIdentifier)
        
        menuTableView.separatorStyle = .None
        menuTableView.scrollsToTop = false
        menuTableView.scrollEnabled = false
        menuTableView.rowHeight=SizeUtil.convertIphone6ToIphone5(45)
        
        if UserModel.isUserLoggedIn(){
            lblName.text = UserModel.getUserName();
            lblJoiningDate.text = "Joining Date : " + UserModel.getUserJoinDate()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuController.refreshView), name:Constant.updateSideMenu, object: nil)
        
        loadControllers()
        
    }
    
    func refreshView(){
        
        if UserModel.isUserLoggedIn(){
            lblName.text = UserModel.getUserName();
            lblJoiningDate.text = "Joining Date : " + UserModel.getUserJoinDate()
            self.menuTableView.reloadData()

        }
        self.menuTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _mainMenu.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return menuCellAtIndexPath(indexPath)
    }
    
    func menuCellAtIndexPath(indexPath:NSIndexPath) -> MenuTableCell {
        
        let cell = menuTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MenuTableCell
        setCellData(cell,indexPath : indexPath)
         print(_mainMenu.count)
        
        return cell
    }
    func setCellData(tableCell:MenuTableCell,indexPath:NSIndexPath){
        
        _menu = _mainMenu.objectAtIndex(indexPath.row) as! Menu
        tableCell.menuNameLabel.text = _menu.name
        tableCell.menuIcon.image = UIImage(named: _menu.imageUrl)
        tableCell.selectionStyle = UITableViewCellSelectionStyle.None
        tableCell.viewSeperator.hidden = true
        if indexPath.row == _mainMenu.count - 2{
            tableCell.viewSeperator.hidden = false
        }
        
        if indexPath.row == _mainMenu.count - 1 && !UserModel.isUserLoggedIn(){
            tableCell.menuNameLabel.text = "LogIn"
            
        }
        
        if indexPath.row == _mainMenu.count - 4 && !UserModel.isUserLoggedIn(){
        
           tableCell.tag = indexPath.row
            if tableCell.tag == 2{
                tableCell.hidden = true
            
            }
            print( "Tag of Particualar Cell",tableCell.menuNameLabel.tag)
        }
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    print("did select row: \(indexPath.row)", terminator: "")
        
        if UserModel.isUserLoggedIn(){
              self.refreshView()
        
        }
        menuTableView.reloadData()
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
        
       


 }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        var rowHeight:CGFloat = 0.0
        if(indexPath.row == 2 && !UserModel.isUserLoggedIn()){
            rowHeight = 0.0
        }
        else{
            rowHeight = 45.0    //or whatever you like
        }
        return rowHeight
 
    }
    
    func changeViewController(menu: LeftMenu) {
        
      //  let defaults = NSUserDefaults.standardUserDefaults()
        
        switch menu {
          
        case .BROWSE_OFFER:
            self.slideMenuController()?.changeMainViewController(self._browseOfferController, close: true)
            break
        case .SAVED_OFFER:
            if !UserModel.isUserLoggedIn(){
                UserModel.setControllerName("saved")
                 showDialougeForGuest()
                   return
            
            }
            self.slideMenuController()?.changeMainViewController(self._savedOfferController, close: true)
            break
        case .MY_RETAILER:
            self.slideMenuController()?.changeMainViewController(self._mainViewController, close: true)
            break
        case .PERKUP:
            if !UserModel.isUserLoggedIn(){
                UserModel.setControllerName("myPerkup")
                showDialougeForGuest()
               return
            }
            self.slideMenuController()?.changeMainViewController(self._profileController, close: true)
            break
        case .SETTING:
            if !UserModel.isUserLoggedIn(){
                showDialougeForGuest()
                
                
                return
            }
            self.slideMenuController()?.changeMainViewController(self._settingsController, close: true)
            break
        case .LOGOUT:
                 print("User Logged In")
                 if UserModel.isUserLoggedIn(){
                 objMenu.getMainMenu()
                 self.refreshView()
                flashDataFromMemory()
                self.slideMenuController()?.changeMainViewController(self._authViewController, close: true)
                    break
                 }else{
                    objMenu.getMainMenu()
                    self.refreshView()
                    self.slideMenuController()?.changeMainViewController(self._authViewController, close: true)

                break
            }
                
            
            
        }
    }

    
    
    func loadControllers(){
        
        let mainController = storyboard!.instantiateViewControllerWithIdentifier("MyRetailersViewController") as! MyRetailersViewController
        self._mainViewController = UINavigationController(rootViewController: mainController)
        
        let aboutController = storyboard!.instantiateViewControllerWithIdentifier("AuthController") as! AuthController
        self._authViewController = UINavigationController(rootViewController: aboutController)
        
        let browseOfferController = storyboard!.instantiateViewControllerWithIdentifier("OfferMainController") as! OfferMainController
        self._browseOfferController = UINavigationController(rootViewController: browseOfferController)
        
        let settingController = storyboard!.instantiateViewControllerWithIdentifier("SettingsController") as! SettingsController
        self._settingsController = UINavigationController(rootViewController: settingController)
        
        let profileController = storyboard!.instantiateViewControllerWithIdentifier("ProfileController") as! ProfileController
        self._profileController = UINavigationController(rootViewController: profileController)
        
        let savedController = storyboard!.instantiateViewControllerWithIdentifier("SavedDetailController") as! SavedDetailController
        self._savedOfferController = UINavigationController(rootViewController: savedController)
        

    }
    
    func flashDataFromMemory(){
        
        UserModel.setUserLoggedIn(false)
        UserModel.setConnectedFromFb(false);
        UserModel.saveUserDealCount(0);
    }
    
    func showDialougeForGuest(){
        slideMenuController()?.closeLeft()
        AppDelegate.getInstatnce().createAlertView()
        
    }
    

}



