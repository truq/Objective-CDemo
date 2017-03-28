//
//  SavedDetailController.swift
//  PerkUp
//
//  Created by NGI-Noman on 04/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class SavedDetailController: BaseController,UITableViewDataSource,UITableViewDelegate,EditOfferTableCellDelegate  {

    @IBOutlet weak var saveOfferTableView: UITableView!
    @IBOutlet weak var lblInfo: UILabel!
    var _offer : Offer!
    var arrayOfferId:NSMutableArray = NSMutableArray()
    var _savedOfferArray :NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setNavigationTitleText("Saved Deals")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        loadSavedOffer();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true

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
        return SizeUtil.convertIphone6ToIphone5(339)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _savedOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        saveOfferTableView.contentInset = UIEdgeInsetsZero;
 
        
        let identifier = "AllOfferCell\(indexPath)"
        
        
        var cell:EditOfferTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? EditOfferTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("EditOfferTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? EditOfferTableCell
        }
        cell!.customDelegate = self
        cell!.btnCross.tag = indexPath.row
        cell!.selectionStyle = .None
        
        if _savedOfferArray.count != 0{
            
            
            //_savedOfferArray.objectAtIndex(indexPath.row)
            
            let hello:SaveOffer = _savedOfferArray.objectAtIndex(indexPath.row) as! SaveOffer
            
            print(hello.offer?.offer_image)
            
            
            cell!.setCellDataForSaveOffer(_savedOfferArray.objectAtIndex(indexPath.row) as! SaveOffer);
            
        }
        return cell!
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select called")
       let cell = tableView.cellForRowAtIndexPath(indexPath) as! EditOfferTableCell
        getOfferDetailById(self.arrayOfferId.objectAtIndex(indexPath.row) as! String);
        print("Offer id",self.arrayOfferId.objectAtIndex(indexPath.row) as! String)
        print(" CEll Offer id",cell._offer_id)

        
    }

    //*******************************************
    func getOfferDetailById(offerId:String){
        
        Alert.showLoader("");
        // add header
        ServiceWrapper.getOfferByID("\(Constant.baseUrlForOffer)offers/\(offerId)",header: ["":""], params: ["":""]) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataDict = response.objectForKey("offer") as? NSDictionary{
                    
                    self._offer = Offer();
                    self._offer.setDatafromServer(dataDict)
                    print("welcome",self._offer)
                    self.performSegueWithIdentifier("detailController", sender: self);
                    
                }
                
            }
            
        }
    
    }

    
  /// *********************************
    
    
    
    
    func loadSavedOffer(){
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["access_token":UserModel.getUserToken()]
        
        ServiceWrapper.getAllBookedOffer("\(Constant.baseUrlForSecure)userfavorites",header: header, param: dict) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataArray = response.objectForKey("favorites") as? NSArray{
                    
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                        return
                    }
                    
                   self._savedOfferArray.removeAllObjects()
                    
                    for item in dataArray{
                        let saveOffer = SaveOffer()
                        saveOffer.setDataFromServer(item as! NSDictionary)
                        self._savedOfferArray.addObject(saveOffer);
                        self.arrayOfferId.addObject((saveOffer.offer?.offer_id)!)
                        print("Saved Offers:",saveOffer.offer?.offer_id)
                        
                        // for Detail Offer Changing
                        
                        
                        
                    }
                    print(self._savedOfferArray);
                    self.saveOfferTableView.reloadData();
                    
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        
    }
    
    //MArk Edit Offer TableCell Delegate
    func deleteOfferFromList(sender: AnyObject) {
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["access_token":UserModel.getUserToken()]
        
        print(UserModel.getUserSessionKey())
        print(UserModel.getUserToken())
        
        let indexpath = NSIndexPath(forItem: sender.tag, inSection: 0);
        let cell = tableView(saveOfferTableView, cellForRowAtIndexPath: indexpath) as! EditOfferTableCell
        
        
        
        
        
        ServiceWrapper.removeSavedOffer("\(Constant.baseUrlForSecure)userfavorites/\(cell._offer_id)", header: header, requestObject: dict) { (success, response) -> Void in
            
            if (success){
                
                print(response);

                
                if self._savedOfferArray.count != 0{
                    self._savedOfferArray.removeObjectAtIndex(sender.tag)
                    self.saveOfferTableView.reloadData();
                }
                else{
                    
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == "detailController" ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }

    
    

}