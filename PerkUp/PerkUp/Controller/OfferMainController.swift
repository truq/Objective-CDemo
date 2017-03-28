//
//  OfferMainController.swift
//  PerkUp
//
//  Created by NGI-Noman on 25/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class OfferMainController: BaseController, UISearchBarDelegate{
    
    var _containerViewController = ContainerController()
    var _page = 0;
    @IBOutlet weak var viewIndicator: UIView!
    var lblCounter : UILabel!
    
    @IBOutlet var barButtonCollection: [UIButton]!


    override func viewDidAppear(animated: Bool) {
        
         print("View did load appear")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        createUI();
        addRightButton()
        

        let searchBar = UISearchBar(frame:CGRectMake(0,0,100,30));
        searchBar.delegate = self
        searchBar.placeholder = "Search Offers"
        dispatch_async(dispatch_get_main_queue(), {
            
            for view in searchBar.subviews
            {
                for viewNew in view.subviews
                {
                    if viewNew.isKindOfClass(UITextField)
                    {
                        let textField  =  viewNew as! UITextField
                        
                        let searchIcon = textField.leftView
                        textField.rightView=searchIcon
                        textField.backgroundColor = UIColor.perkupDarkBlue();
                        textField.textColor = UIColor.whiteColor()
                        textField.leftViewMode = UITextFieldViewMode.Never
                        textField.rightViewMode = UITextFieldViewMode.Always
                        
                        
                    }
                }
            }
        })
        
          searchBar.layoutIfNeeded()
          searchBar.layoutSubviews()
          self.navigationItem.titleView = searchBar
        
        

        
        //////////////////////////////////////////////////////////////////////////////////////
        
        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(OfferMainController.respondToSwipeGesture(_:)))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
        
        if !UserModel.isUserHasCity(){
            let changeCityController = storyboard!.instantiateViewControllerWithIdentifier("ChangeCityController") as! ChangeCityController
            self.navigationController?.presentViewController(changeCityController, animated: true, completion: { () -> Void in
                
            })
        }
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        lblCounter.text = "\(UserModel.getUserDealCount())"
        self.lblCounter.hidden = false
        if UserModel.getUserDealCount() < 1 {
            self.lblCounter.hidden = true
        }
        
        
        
        
    }
    override func addRightButton(){
        let button = UIButton(frame: CGRectMake(0, view.center.y, 40, 40))
        button.setImage(UIImage(named: "cart-icon"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(OfferMainController.didTapOnRightButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        lblCounter = UILabel(frame: CGRectMake(25,2,13,13))
        lblCounter.backgroundColor = UIColor.redColor();
        lblCounter.text = "\(UserModel.getUserDealCount())"
        lblCounter.textColor = UIColor.whiteColor()
        lblCounter.layer.cornerRadius = 13/2
        lblCounter.layer.masksToBounds = true
        lblCounter.clipsToBounds = true
        lblCounter.textAlignment = NSTextAlignment.Center
        lblCounter.font = UIFont(name: Constant.AppFontRegular, size: 11)
        button.addSubview(lblCounter)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    override func didTapOnRightButton(){
        let defaults =  NSUserDefaults.standardUserDefaults()

        
        
        if !UserModel.isUserLoggedIn(){
            UserModel.setControllerName(" ")
            AppDelegate.getInstatnce().createAlertView()
                           defaults.setBool(true, forKey:"tapOnCart")
            
         return
            
            
        }else{
            defaults.setBool(false, forKey:"tapOnCart")

        
        }
        
        
        
        let bookingController = storyboard!.instantiateViewControllerWithIdentifier("BookedDetailController") as! BookedDetailController
        self.navigationController?.pushViewController(bookingController, animated: true)
        
        
        
        
        
    }
    
    
//    
//    func goToBookedOfferScreen() {
//        
//        
//        
//
//        
//        
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil);
//        let bookingController = storyboard.instantiateViewControllerWithIdentifier("BookedDetailController") as! BookedDetailController
//  
//        let navigationController: UINavigationController = UINavigationController()
//        
//        navigationController.pushViewController(bookingController, animated: true)
//        
////        let nvc: UINavigationController = UINavigationController(rootViewController: bookingController)
//
//           print("Navigation Controller is:",navigationController)
//           //self.navigationController?.pushViewController(bookingController, animated:true)
//           print("Welcome")
//        
//        
//    }
    
    
    
    
    
    func createUI(){
        for item in barButtonCollection{
            
            if item.tag == 2{
                item.selected = true
                dispatch_async(dispatch_get_main_queue(), {
                    self.animateViewIndicator(item)
                    self._page = item.tag
                })
                
                break;
            }
            
        }
    }
    
    @IBAction func didTapOnTabbarItem(sender:UIButton){
        
        _containerViewController.swapViewControllers(sender.tag);
        animateViewIndicator(sender)
        
    }
    
    func animateViewIndicator(sender:UIButton){
        
        for item in barButtonCollection{
            item.selected = false
        }
        
        if !sender.selected{
            sender.selected = true
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.viewIndicator.frame = CGRectMake(sender.frame.origin.x, self.viewIndicator.frame.origin.y, sender.frame.size.width, 2);
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == Constant.sw_embed_container{
            _containerViewController = segue.destinationViewController as! ContainerController
        }
        
    }
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
                if _page < 3{
                    _page += 1
                    _containerViewController.swapViewControllers(_page);
                    let tmpButton = self.view.viewWithTag(_page) as? UIButton
                    animateViewIndicator(tmpButton!)
                }
                
            case UISwipeGestureRecognizerDirection.Left:
                
                if _page > 1{
                    _page -= 1
                    _containerViewController.swapViewControllers(_page);
                    let tmpButton = self.view.viewWithTag(_page) as? UIButton
                    animateViewIndicator(tmpButton!)
                }
                
                print("Swiped left")
            default:
                break
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchController = storyboard!.instantiateViewControllerWithIdentifier("SearchController") as! SearchController
        searchController._searchString = searchBar.text!
        self.navigationController?.pushViewController(searchController, animated: false)
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    
}



