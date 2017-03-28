//
//  SearchController.swift
//  PerkUp
//
//  Created by NGI-Noman on 13/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class SearchController: BaseController {
    
    var _searchedOfferArray : NSMutableArray = NSMutableArray()
    var _offer : Offer!
    var _searchString : String!
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addLeftButton()
        searchOffer()
        setNavigationTitleText("Offers")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true
    }
    
    func searchOffer(){
        Alert.showLoader("Searching.....")
        
        
               
        let originalUrl = "\(Constant.baseUrlForOffer)offers/search/\(_searchString)"
        
        let urlString :String = originalUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!

        
        print(urlString)
        
        
        // add header
        ServiceWrapper.searchOfferByString(urlString, header: ["":""], params: ["":""]) { (success, response) -> Void in
            Alert.hideLoader()
            if (success){
                
                print(response);
                
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                        return
                    }
                    
                    for item in dataArray{
                        let offer = Offer()
                        offer.setDatafromServer(item as! NSDictionary)
                        self._searchedOfferArray.addObject(offer);
                    }
                    self.searchTableView.reloadData()
                    
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
        return _searchedOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "offerCell\(indexPath)"
        
        
        var cell:LocationTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? LocationTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("LocationTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? LocationTableCell
        }
        
        if _searchedOfferArray.count != 0{
            cell!.setCellData(_searchedOfferArray.objectAtIndex(indexPath.row) as! Offer);
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
        // add header
        ServiceWrapper.getOfferByID("\(Constant.baseUrlForOffer)offers/\(offerId)",header: ["":""],  params: ["":""]) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataDict = response.objectForKey("offer") as? NSDictionary{
                    
                    self._offer = Offer();
                    self._offer.setDatafromServer(dataDict)
                    self.performSegueWithIdentifier("pushfromsearch", sender: self);
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == "pushfromsearch" ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }
    

}



