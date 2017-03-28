//
//  BookedDetailController.swift
//  PerkUp
//
//  Created by NGI-Noman on 04/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit

class BookedDetailController: BaseController,UITableViewDataSource,UITableViewDelegate,EditOfferTableCellDelegate,PerkupAlertViewDelegate {
    
    var _alertView : PerkupAlertView!

    
    @IBOutlet weak var viewAlertYESNO: UIView!
    
    @IBOutlet weak var lblYESNO: UILabel!
    
    @IBOutlet weak var btnNO: UIButton!
    @IBOutlet weak var btnYES: UIButton!
    
    
    @IBOutlet weak var bookedDetailTableVIew: UITableView!
    var _offer : Offer!
    var arrayOfferId:NSMutableArray = NSMutableArray()

    var _bookedOfferArray : NSMutableArray = NSMutableArray();

    @IBOutlet weak var lblInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(_bookedOfferArray);
    
        loadBookedOffer();
        addLeftButton();
        
        setNavigationTitleText("Booked Deals")
        self.customizeUI()
        
        
        
    }

    func customizeUI(){
    
        
        viewAlertYESNO.frame = CGRectMake(0, 64, self.view.frame.size.width,SizeUtil.convertIphone6ToIphone5(self.view.frame.height))
        viewAlertYESNO.layer.cornerRadius = Constant.CommonRadius
        lblYESNO.text = "Are you sure you want to delete this offer? "
        viewAlertYESNO.backgroundColor = UIColor.alertBGColor()
        btnNO.layer.cornerRadius = Constant.CommonRadius
        btnYES.layer.cornerRadius = Constant.CommonRadius
            
            
            

        
    
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
        return _bookedOfferArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "BookOfferCell\(indexPath)"
        
        var cell:EditOfferTableCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? EditOfferTableCell
        if  (cell==nil){
            let nib:NSArray=NSBundle.mainBundle().loadNibNamed("EditOfferTableCell", owner: self, options: nil)
            cell = nib.objectAtIndex(0) as? EditOfferTableCell
        }
        cell!.customDelegate = self
        cell!.btnCross.tag = indexPath.row
        cell!.btnCross.tag = indexPath.row
        if _bookedOfferArray.count != 0{
            
            cell!.setCellData(_bookedOfferArray.objectAtIndex(indexPath.row) as! Booking);
        }
        
        cell!.selectionStyle = .None
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select called")
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EditOfferTableCell
        getOfferDetailById(self.arrayOfferId.objectAtIndex(indexPath.row) as! String);
        print("Offer id",self.arrayOfferId.objectAtIndex(indexPath.row) as! String)
        print(" CEll Offer id",cell._offer_id)
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
                    print("welcome",self._offer)
                    self.performSegueWithIdentifier("bookedToOfferDetail", sender: self);
                    
                }
                
            }
            
        }
        
    }
    

    
    func loadBookedOffer(){
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["access_token":UserModel.getUserToken()]
        
        ServiceWrapper.getAllBookedOffer("\(Constant.baseUrlForSecure)booking",header: header, param: dict) { (success, response) -> Void in
            
            if (success){
                
                print(response);
                
                if let dataArray = response.objectForKey("booking") as? NSArray{
                    
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                        self.lblInfo.hidden = false
                        return
                    }
                    //Mark : adding items in array
                    for item in dataArray{
                        let booking = Booking()
                         booking.setDataFromServer(item as! NSDictionary)
                        self._bookedOfferArray.addObject(booking);
                        self.arrayOfferId.addObject((booking.offer?.offer_id)!)

                        
                    }
                    //Mark: reload Data
                    self.bookedDetailTableVIew.reloadData();
                    UserModel.saveUserDealCount(self._bookedOfferArray.count);
                    
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        
    }
    
    //MArk Edit Offer TableCell Delegate
    func deleteOfferFromList(sender: AnyObject) {
        
        
        
        self.view.addSubview(viewAlertYESNO)
        
                
        
        
        }
    
    func decreaseDealCounter() {
        if UserModel.getUserDealCount() > 0{
            UserModel.saveUserDealCount( UserModel.getUserDealCount() - 1)
        }
        if UserModel.getUserDealCount() < 1 {
            lblInfo.hidden = false
        }
    }

    
    @IBAction func closeAlertYESNO(sender: AnyObject) {
        
        viewAlertYESNO.removeFromSuperview()
    }
    
    
    @IBAction func didTapYES(sender: AnyObject) {
        
        
        
        viewAlertYESNO.removeFromSuperview()
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        let dict = ["access_token":UserModel.getUserToken()]
        
        print(UserModel.getUserSessionKey())
        print(UserModel.getUserToken())
        
        let indexpath = NSIndexPath(forItem: sender.tag, inSection: 0);
        let cell = self.tableView(self.bookedDetailTableVIew, cellForRowAtIndexPath: indexpath) as! EditOfferTableCell
        
        ServiceWrapper.removeBookedOffer("\(Constant.baseUrlForSecure)booking/\(cell._offer_id)", header: header, requestObject: dict) { (success, response) -> Void in
            
            if (success){
                
                
                if self._bookedOfferArray.count != 0{
                    self._bookedOfferArray.removeObjectAtIndex(sender.tag)
                    self.bookedDetailTableVIew.reloadData();
                    //Mark: Deal Counter decrement
                    self.decreaseDealCounter();
                    
                   // Alert.showAlert("Deal", message:"")
                    self.createAlertView("Deal Removed Successfully", btnTitleText: "Ok")

                }
                else{
                 
                     self.createAlertView("You Have No booked deal", btnTitleText: "Ok")
                    //Alert.showAlert("", message: "You Have No booked deal")
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
            
        }
        

        
    }
   
    @IBAction func didTapNO(sender: AnyObject) {
        viewAlertYESNO.removeFromSuperview()
        
    }
    
    
    func createAlertView(lblInfoText:String ,btnTitleText:String){
        
        _alertView = PerkupAlertView(frame:(AppDelegate.getInstatnce().window?.bounds)!)
        _alertView.customDelegate = self
        AppDelegate.getInstatnce().window?.addSubview(_alertView);
        
        _alertView.viewRegister.hidden = true
        _alertView.viewOnRegComplete.hidden = false
        _alertView.btnCloseWhite.setImage(UIImage(named: "close-blue"), forState: UIControlState.Normal)
        
        _alertView.btnContinue.setTitle(btnTitleText, forState: UIControlState.Normal)
        _alertView.lbl_info.text = lblInfoText
        
    }
    
    // Delegate
    func removeAlertView() {
        _alertView.removeFromSuperview();
    }
    func performAction(sender: AnyObject) {
        //
        _alertView.removeFromSuperview();
//        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("BookedDetailController") as! BookedDetailController
//        self.navigationController?.pushViewController(mainViewController, animated: true)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == "bookedToOfferDetail" ) {
            
            if let detailController = segue.destinationViewController as? OfferDetailController{
                detailController._offer = self._offer
            }
            
        }
        
    }
    

    
    
    
}
