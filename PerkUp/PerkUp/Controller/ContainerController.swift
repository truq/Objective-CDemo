//
//  ContainerController.swift
//  PerkUp
//
//  Created by NGI-Noman on 25/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit


enum OFFER_VIEWS : Int{
    case CATEGORIES = 1
    case FEATURED = 2
    case LOCATION = 3
};

class ContainerController: UIViewController{
    
    
    var _categoriesController = CategoriesController()
    var _featuredController = FeaturedController()
    var _locationController = LocationController()
    
    var _currentSegueIdentifier : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _currentSegueIdentifier = Constant.sw_featured
        self.performSegueWithIdentifier(_currentSegueIdentifier, sender: nil);
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == Constant.sw_categories{
            
            _categoriesController = segue.destinationViewController as! CategoriesController;
            
        }
        if segue.identifier == Constant.sw_featured{
            
            _featuredController = segue.destinationViewController as! FeaturedController;
            
        }
        if segue.identifier == Constant.sw_locations{
            
            _locationController = segue.destinationViewController as! LocationController;
        }
        
        
        
        // If we're going to the first view controller.
        
        
        if segue.identifier == Constant.sw_featured{
            
            if self.childViewControllers.count > 0{
                swapFromViewController(self.childViewControllers.last!, toViewController: _featuredController);
            }
            else{
                self.addChildViewController(segue.destinationViewController)
                let destView = segue.destinationViewController.view
                destView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
                destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.view.addSubview(destView);
                segue.destinationViewController.didMoveToParentViewController(self);
            }
            
        }
        
        // By definition the second view controller will always be swapped with the
        // first one.
        else if segue.identifier == Constant.sw_categories {
            swapFromViewController(self.childViewControllers.last!, toViewController: _categoriesController);
        }
        else if segue.identifier == Constant.sw_locations {
            swapFromViewController(self.childViewControllers.last!, toViewController: _locationController);
        }
        
        
        
    }
    
    // Mark : SwapViewController 
    
     func swapViewControllers(index:Int){
        
        switch index{
        case OFFER_VIEWS.CATEGORIES.rawValue:
            _currentSegueIdentifier = Constant.sw_categories
            break;
        case OFFER_VIEWS.FEATURED.rawValue:
            _currentSegueIdentifier = Constant.sw_featured
            break;
        case OFFER_VIEWS.LOCATION.rawValue:
            _currentSegueIdentifier = Constant.sw_locations
            break;
        default:
            break;
        }
        
        print(_currentSegueIdentifier);
        
        self.performSegueWithIdentifier(_currentSegueIdentifier, sender: nil);
        
        
    }
    func swapFromViewController(fromViewController:UIViewController, toViewController:UIViewController){
        
        
        fromViewController.willMoveToParentViewController(nil)
        fromViewController.view.removeFromSuperview()
        fromViewController.removeFromParentViewController()
        
        
        self.addChildViewController(toViewController);
        let destView = toViewController.view
        destView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.addSubview(destView);
        toViewController.didMoveToParentViewController(self)
        
//        self.transitionFromViewController(fromViewController, toViewController: toViewController, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: nil) { (Bool) -> Void in
//
//        }
    }


}
