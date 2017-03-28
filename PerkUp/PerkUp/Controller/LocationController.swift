//
//  LocationController.swift
//  PerkUp
//
//  Created by NGI-Noman on 25/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit


class LocationController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    @IBOutlet weak var lblInfo: UILabel!
    var _indexNumber : NSIndexPath!
    var _locationOfferArray : NSMutableArray = NSMutableArray()
    var _locationAreaArray : NSMutableArray = NSMutableArray()
    var _offer : Offer!
    var didSelect = false
    var count = 0
    
    @IBOutlet weak var locationOfferTableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {

        let defaults = NSUserDefaults.standardUserDefaults()
        if didSelect
        {
            loadOfferByLocation(defaults.objectForKey("area_id") as! String)
        }
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //offerCollectionView!.registerNib(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "offerCollectionCell")
        
        offerCollectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       loadAreasByCity();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true
    }
    
    func loadOfferByLocation(areaID:String){
       
        print("Area Id", areaID)
        
        
        self.lblInfo.hidden = true
        Alert.showLoader("Loading.....")
        let dict = ["type":"location",
            "type_id":areaID]
        
        ServiceWrapper.getFeaturedOffer("\(Constant.baseUrlForOffer)offers",header: ["":""], params: dict) { (success, response) -> Void in
            if (success){
                
                
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                    }
                    
                    self._locationOfferArray.removeAllObjects();
                    for item in dataArray{
                        let offer = Offer()
                        offer.setDatafromServer(item as! NSDictionary)
                        self._locationOfferArray.addObject(offer)
                    }
                    self.locationOfferTableView.reloadData()
                    
                }
                
                

            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }
    func loadAreasByCity(){
        // add header
        ServiceWrapper.getAreaByCity("\(Constant.baseUrlForOffer)location/city/karachi",header: ["":""], params: ["":""] as NSDictionary) { (success, response) -> Void in
            if (success){
                ///////////////////////////////
                let responseData = response.objectForKey("city") as! NSArray
                if responseData.count != 0{
                    
                    for item in responseData{
                        let city = City()
                        city.setDatafromServer(item as! NSDictionary)
                        self._locationAreaArray.addObject(city)
                    }

                    self.offerCollectionView.reloadData()
                    Alert.hideLoader()
                    self.loadOfferByLocation(responseData.objectAtIndex(0).objectForKey("area_id") as! String)
                    self._indexNumber = NSIndexPath(forRow: 0, inSection: 0)
                    
                }
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int {
            return 1
    }
    func collectionView(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
            return _locationAreaArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView,cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            
           let reuseIdentifier = "offerCollectionCell\(indexPath.row)"
            offerCollectionView!.registerNib(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:reuseIdentifier)
            
            var cell : OfferCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
            forIndexPath: indexPath) as? OfferCollectionViewCell
            
            if  (cell==nil){
                let nib:NSArray=NSBundle.mainBundle().loadNibNamed("OfferCollectionViewCell", owner: self, options: nil)
                
                cell = nib.objectAtIndex(0) as? OfferCollectionViewCell
            }
            

            /*
             
             if _categoriesArray.count != 0{
             cell?.setCellDataForCategory(_categoriesArray.objectAtIndex(indexPath.row) as! Category)
             
             print("Category:",indexPath.row)
             
             
             if _indexNumber.row == indexPath.row  && count < 1{
             
             print("Welcome index_Number", _indexNumber.row,indexPath.row)
             cell?.lblTitle.textColor = UIColor.whiteColor();
             cell?.viewContainer.backgroundColor = UIColor.perkupOrange();
             cell?.viewContainer.layer.borderColor = UIColor.clearColor().CGColor
             count += 1
             print("count",count)
             }
             else if _indexNumber.row == indexPath.row {
             cell?.lblTitle.textColor = UIColor.darkGrayColor();
             cell?.viewContainer.backgroundColor = UIColor.clearColor();
             cell?.viewContainer.layer.borderColor = UIColor.grayColor().CGColor
             }
             }
*/
            
            
            
            
            if _locationAreaArray.count != 0{
                cell?.setCellData(_locationAreaArray.objectAtIndex(indexPath.row) as! City)
                if _indexNumber.row == indexPath.row && count < 1 {
                    cell?.lblTitle.textColor = UIColor.whiteColor();
                    cell?.viewContainer.backgroundColor = UIColor.perkupOrange();
                    cell?.viewContainer.layer.borderColor = UIColor.clearColor().CGColor
                    count += 1
                
                }else if _indexNumber.row == indexPath.row {
                    cell?.lblTitle.textColor = UIColor.whiteColor();
                    cell?.viewContainer.backgroundColor = UIColor.perkupOrange();
                    cell?.viewContainer.layer.borderColor = UIColor.clearColor().CGColor

                }
            }
            
            return cell!
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 32)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
              
        dispatch_async(dispatch_get_main_queue()) {
        if self._indexNumber != nil{
            
            
            print("Index Number",self._indexNumber)
            
             if let SelectedCell =  collectionView.cellForItemAtIndexPath(self._indexNumber) as? OfferCollectionViewCell {
            SelectedCell.lblTitle.textColor = UIColor.darkGrayColor();
            SelectedCell.viewContainer.backgroundColor = UIColor.clearColor();
            SelectedCell.viewContainer.layer.borderColor = UIColor.grayColor().CGColor
            }
        }
        
        let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! OfferCollectionViewCell
        cell.lblTitle.textColor = UIColor.whiteColor();
        cell.lblTitle.numberOfLines = 0
        cell.viewContainer.backgroundColor = UIColor.perkupOrange();
        cell.viewContainer.layer.borderColor = UIColor.clearColor().CGColor
        self._indexNumber = indexPath
        
        let city  = self._locationAreaArray.objectAtIndex(indexPath.row) as! City
        self.loadOfferByLocation(city.area_id!)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(city.area_id!, forKey:"area_id")
            
            self.didSelect = true
            
            
        }// end of dispatch
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(336)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _locationOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "locationCell\(indexPath)"
        
        
        var cell:LocationTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? LocationTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("LocationTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? LocationTableCell
        }
        
        if _locationOfferArray.count != 0{
            cell!.setCellData(_locationOfferArray.objectAtIndex(indexPath.row) as! Offer);
        }
        //cell?.btnSaveOffer.tag = indexPath.row
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
        ServiceWrapper.getOfferByID("\(Constant.baseUrlForOffer)offers/\(offerId)",header: ["":""], params: ["":""]) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataDict = response.objectForKey("offer") as? NSDictionary{
                    
                    self._offer = Offer();
                    self._offer.setDatafromServer(dataDict)
                    self.performSegueWithIdentifier("pushtolocation", sender: self);
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == "pushtolocation" ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }

        }

    }


}
