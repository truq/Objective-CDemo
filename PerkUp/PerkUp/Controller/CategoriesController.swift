//
//  CategoriesController.swift
//  PerkUp
//
//  Created by NGI-Noman on 25/03/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

class CategoriesController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var count = 0

    @IBOutlet weak var lblInfo: UILabel!
    var _indexNumber : NSIndexPath!
    var _categoryOfferArray : NSMutableArray = NSMutableArray()
    var _categoriesArray : NSMutableArray = NSMutableArray()
    var _offer : Offer!
    var didSelect = false

    @IBOutlet weak var categoryTableView: UITableView!
    
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if didSelect
         {
             loadOfferByCategories(defaults.objectForKey("category_id") as! String)
         }

    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        categoriesCollectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        loadCategories()

    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblInfo.hidden = true
    }
    
    func loadOfferByCategories(categoryID:String){
         self.lblInfo.hidden = true
        Alert.showLoader("Loading...")
       
        
        
        //let header = ["sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["type":"category","type_id":categoryID]
        
       // print("dictionary Welcome \(dict): Header :\(header)")
        
        
        ServiceWrapper.getFeaturedOffer("\(Constant.baseUrlForOffer)offers", header:["":""]  ,params: dict) { (success, response) -> Void in
            if (success){
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                    }
                    self._categoryOfferArray.removeAllObjects()
                    for item in dataArray{
                        let offer = Offer()
                        offer.setDatafromServer(item as! NSDictionary)
                        self._categoryOfferArray.addObject(offer)
                        
                    }
                    self.categoryTableView.reloadData()
                    
                }
                

            }
        }
        
    }
    
    func loadCategories(){
        Alert.showLoader("")
        //add Header
        
        
              
        
        
        ServiceWrapper.getAreaByCity("\(Constant.baseUrlForOffer)category",header: ["":""], params: ["":""] as NSDictionary) { (success, response) -> Void in
            if (success){
                
              let responseData = response.objectForKey("categories") as! NSArray
                
                if responseData.count != 0{
                    
                    for item in responseData{
                        let category = Category()
                        category.setDatafromServer(item as! NSDictionary)
                        self._categoriesArray.addObject(category)
                    }
                    self.categoriesCollectionView.reloadData()
                    Alert.hideLoader()
                    
                       self.loadOfferByCategories(responseData.objectAtIndex(0).objectForKey("category_id") as! String)
                    self._indexNumber = NSIndexPath(forRow: 0, inSection: 0)
                    
                }
                
            }else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }
    //MArk : CollectionView Delegate
    

    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return _categoriesArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView,cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            
          let reuseIdentifier = "offerCollectionCell\(indexPath.row))"
            categoriesCollectionView!.registerNib(UINib(nibName: "OfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
            
            var cell : OfferCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
                forIndexPath: indexPath) as? OfferCollectionViewCell
            
            
            
            if  (cell==nil){
                let nib:NSArray=NSBundle.mainBundle().loadNibNamed("OfferCollectionViewCell", owner: self, options: nil)
                cell = nib.objectAtIndex(0) as? OfferCollectionViewCell
                
            }
            
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
//                    cell?.lblTitle.textColor = UIColor.darkGrayColor();
//                    cell?.viewContainer.backgroundColor = UIColor.clearColor();
//                    cell?.viewContainer.layer.borderColor = UIColor.grayColor().CGColor
                    
                    cell?.lblTitle.textColor = UIColor.whiteColor();
                    cell?.viewContainer.backgroundColor = UIColor.perkupOrange();
                    cell?.viewContainer.layer.borderColor = UIColor.clearColor().CGColor
                }
            }
            
            return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("Index number \(_indexNumber)")
        
        dispatch_async(dispatch_get_main_queue()) {
            
            if self._indexNumber != nil{
                
                
                if let SelectedCell =  self.categoriesCollectionView.cellForItemAtIndexPath(self._indexNumber) as? OfferCollectionViewCell{
                SelectedCell.lblTitle.textColor = UIColor.darkGrayColor();
                SelectedCell.viewContainer.backgroundColor = UIColor.clearColor();
                SelectedCell.viewContainer.layer.borderColor = UIColor.grayColor().CGColor
                }
            }
            
            let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! OfferCollectionViewCell
            cell.lblTitle.textColor = UIColor.whiteColor();
            cell.viewContainer.backgroundColor = UIColor.perkupOrange();
            cell.viewContainer.layer.borderColor = UIColor.clearColor().CGColor

            self._indexNumber = indexPath
            
            let category = self._categoriesArray.objectAtIndex(indexPath.row) as! Category
            self.loadOfferByCategories(category.category_id!)
            let defaults = NSUserDefaults.standardUserDefaults()
                          defaults.setObject(category.category_id, forKey:"category_id")
            
            self.didSelect = true
            
            
        }
        
        }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 32)
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
        return _categoryOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "categoryCell\(indexPath)"
        
        var cell:LocationTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? LocationTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("LocationTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? LocationTableCell
        }
        if _categoryOfferArray.count != 0{
            cell!.setCellData(_categoryOfferArray.objectAtIndex(indexPath.row) as! Offer);
        }
        cell!.selectionStyle = .None
        return cell!
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! LocationTableCell
        getOfferDetailById(cell._offer_id);
        
        
    }
    
    func getOfferDetailById(offerId:String){
        
        
       // let header = ["sessionkey":UserModel.getUserSessionKey()]
        
      //  let dict = ["access_token":UserModel.getUserToken()]
        
        
        
        Alert.showLoader("");
        
        
        
        // add Header
        ServiceWrapper.getOfferByID("\(Constant.baseUrlForOffer)offers/\(offerId)",header: ["":""], params: ["":""]) { (success, response) -> Void in
            
            if (success){
                
                print("Offers",response);
                
                if let dataDict = response.objectForKey("offer") as? NSDictionary{
                    
                    self._offer = Offer();
                    self._offer.setDatafromServer(dataDict)
                    self.performSegueWithIdentifier("pushtocategory", sender: self);
                    
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
        
        if ( segue.identifier == "pushtocategory" ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }

}
