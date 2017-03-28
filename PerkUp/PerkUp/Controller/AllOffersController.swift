//
//  AllOffersController.swift
//  PerkUp
//
//  Created by NGI-Noman on 01/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class AllOffersController: BaseController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblAllOfferTitle: UILabel!
    @IBOutlet weak var allOfferTableView: UITableView!
    @IBOutlet weak var lblInfo: UILabel!
    
    var _allOfferArray : NSMutableArray = NSMutableArray()
    var _offer : Offer!
    var passedId: String!
    var passedBusinessName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if passedId != nil{
           loadOffersByRetailer(passedId!);
            print("PassedId")
        }else{
            loadOffersByRetailer(_offer.business_id!);

        }
            addLeftButton()
        setNavigationTitleText("Retailer Deals")
        // Do any additional setup after loading the view.
        let str:NSMutableAttributedString!
        lblAllOfferTitle.textColor = UIColor.perkupOrange()
        if passedBusinessName != nil{
            str = NSMutableAttributedString(string:"All Offers from \(passedBusinessName!)")
        }else{
            str = NSMutableAttributedString(string:"All Offers from \(_offer.business_name!)")

        
        }
        
        let selectedRange = NSMakeRange(0, 15)
        str.beginEditing()
         str.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range:selectedRange)
        str.endEditing()
        
        lblAllOfferTitle.attributedText = str
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true
    }
    
    func loadOffersByRetailer(retailerID:String){
        
        Alert.showLoader("Loading.....")
        
        let dict = ["type":"retailer",
            "type_id":retailerID]
        
        ServiceWrapper.getFeaturedOffer("\(Constant.baseUrlForOffer)offers",header: ["":""], params: dict) { (success, response) -> Void in
            if (success){
                
                
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                        return
                    }
                    self._allOfferArray.removeAllObjects()
                    for item in dataArray{
                        let offer = Offer()
                        offer.setDatafromServer(item as! NSDictionary)
                        self._allOfferArray.addObject(offer)
                    }
                    self.allOfferTableView.reloadData()
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(336)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _allOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "AllOfferCell\(indexPath)"
        
        
        var cell:LocationTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? LocationTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("LocationTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? LocationTableCell
        }
        if _allOfferArray.count != 0{
            cell!.setCellData(_allOfferArray.objectAtIndex(indexPath.row) as! Offer);
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
                    
                    self.performSegueWithIdentifier(Constant.sw_push_all_to_detail, sender: self);
                    
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
        
        if ( segue.identifier == Constant.sw_push_all_to_detail ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }
    

}
