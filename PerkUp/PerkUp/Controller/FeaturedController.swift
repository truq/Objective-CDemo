//
//  FeaturedController.swift
//  PerkUp
//
//  Created by NGI-Noman on 25/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class FeaturedController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblInfo: UILabel!
    
    var _featuredOfferArray : NSMutableArray = NSMutableArray()
    var _offer : Offer!
    
    @IBOutlet weak var feturedOfferTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadFeatureOffer()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.lblInfo.text = "You have no Featured"
        //viewDidAppear(true)

        //loadFeatureOffer();
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadFeatureOffer(){
        
        let dict = ["type":"featured"]
        Alert.showLoader("Loading.....")
        ServiceWrapper.getFeaturedOffer("\(Constant.baseUrlForOffer)offers",header: ["":""], params: dict) { (success, response) -> Void in
            if (success){
                
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                        return
                    }
                    
                    for item in dataArray{
                        self.lblInfo.hidden = true
                        let offer = Offer()
                        offer.setDatafromServer(item as! NSDictionary)
                        self._featuredOfferArray.addObject(offer)
                        self.feturedOfferTableView.reloadData()
                        
                    }
                }
                

                
             }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(336)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _featuredOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "offerCell\(indexPath)"
        
        
        var cell:LocationTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? LocationTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("LocationTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? LocationTableCell
        }
        
        if _featuredOfferArray.count != 0{
            cell!.setCellData(_featuredOfferArray.objectAtIndex(indexPath.row) as! Offer);
        }
        
        cell!.selectionStyle = .None
        return cell!
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! LocationTableCell
        getOfferDetailById(cell._offer_id);
        
    }
    
    func getOfferDetailById(offerId:String){
        
        Alert.showLoader("");
        // Add Header
        ServiceWrapper.getOfferByID("\(Constant.baseUrlForOffer)offers/\(offerId)",header: ["":""], params: ["":""]) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataDict = response.objectForKey("offer") as? NSDictionary{
                    
                    self._offer = Offer();
                    self._offer.setDatafromServer(dataDict)
                    self.performSegueWithIdentifier(Constant.sw_pushtofeatured, sender: self);
                    
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == Constant.sw_pushtofeatured ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
