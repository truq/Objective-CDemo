//
//  RetailersDetailViewController.swift
//  PerkUp
//
//  Modified by NGI-Noman on 01/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit
import FBSDKLoginKit

class RetailersDetailViewController: BaseController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    /*
     
     new Screen iboutlets
     
     */
    
    @IBOutlet weak var lblEarn: UILabel!
    @IBOutlet weak var lblForEvery: UILabel!
    @IBOutlet weak var lblEarnRs: UILabel!
    @IBOutlet weak var lblExpendRs: UILabel!
    @IBOutlet weak var lblforThat: UILabel!
    
    /****************  view 2 ******************/
    
    @IBOutlet weak var lblRedeem: UILabel!
    
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblForEvery2: UILabel!
    @IBOutlet weak var lblRedeemRs: UILabel!
    
    
    
    /*       View 3                        */
    
    @IBOutlet weak var lblYouHave: UILabel!
    @IBOutlet weak var lblNumPointsV3: UILabel!
    
    @IBOutlet weak var lblOnYourV3: UILabel!
    @IBOutlet weak var lblRsV3: UILabel!
    @IBOutlet weak var lblYouCanV3: UILabel!
    
    /*                                     */
    
    @IBOutlet weak var viewWithoutLoyality: UIView!
    var _userTotalPoints = 0
    var _bonusRewardCount = 0
    var _retailerFBRewardDetail : NSDictionary = NSDictionary()
    var _retailerPageDetail : NSDictionary = NSDictionary()
    var _retailer_id : String!
    var retailer: NSDictionary!
    let reObj = Retailers()

    
    @IBOutlet weak var lblAmountAndPoints: UILabel!
    @IBOutlet weak var lblbonusAwards: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTableView: UITableView!
    
    @IBOutlet var alertTableFooterView: UIView!
    @IBOutlet weak var btnConnectWithFb: UIButton!
    
    
    // View Top
    @IBOutlet weak var retailersImage: UIImageView?
    @IBOutlet weak var retailersName: UILabel?
    @IBOutlet weak var retailersAddress: UILabel?

    
    // View UserData

    @IBOutlet weak var points: UILabel?
    @IBOutlet weak var totalVisit: UILabel?
    @IBOutlet weak var activeOffer: UILabel?
    
    // View BonusReward
    @IBOutlet weak var viewBonusReward: UIView?
    @IBOutlet weak var bonusRewards: UILabel?
    
    // View tableview

    @IBOutlet weak var detailTableView: UITableView!
    
    var response:NSDictionary! ;
    var bonusResponse:NSArray! ;
    var retailers: NSDictionary!;
    var retailerID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewWithoutLoyality.hidden = false
        // adding Tap gesture to label
        self.setDesignForNewView()
        
        if Devices.DeviceType.IS_IPHONE_4_OR_LESS || Devices.DeviceType.IS_IPHONE_5{
            lblbonusAwards.layer.cornerRadius = SizeUtil.convertIphone6ToIphone5(6)
            
        
        }else{
        
            lblbonusAwards.layer.cornerRadius = SizeUtil.convertIphone6ToIphone5(7)

        
        }
        
        
//        
//            let likeButton = FBSDKLikeControl()
//            likeButton.objectID = "https://www.facebook.com/FacebookDevelopers"
//            likeButton.frame = CGRectMake(SizeUtil.convertIphone6ToIphone5(210), SizeUtil.convertIphone6ToIphone5(10),SizeUtil.convertIphone6ToIphone5(400),SizeUtil.convertIphone6ToIphone5(30))
//             self.viewBonusReward?.addSubview(likeButton)
//                    
        
        lblbonusAwards.textAlignment = NSTextAlignment.Center
        lblbonusAwards.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5(11))
 
        
        
        
        bonusRewards!.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5(11))
        retailersAddress!.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5(11))
        lblbonusAwards.layer.masksToBounds = true
        lblbonusAwards.clipsToBounds = true
        
        activeOffer?.userInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RetailersDetailViewController.labelAction(_:)))
        activeOffer!.addGestureRecognizer(tap)
        tap.delegate = self
        // Remember to extend your class with UIGestureRecognizerDelegate
        

        
        createUI();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createUI(){
        
        addLeftButton();
        
        alertView.hidden = true
        alertView.backgroundColor = UIColor.alertBGColor()
        alertTableView.backgroundColor = UIColor.clearColor()
        
        loadRetailerData();
        
        if UserModel.isConnectedFromFb(){
            self.btnConnectWithFb.setImage(nil, forState: UIControlState.Normal);
            self.btnConnectWithFb.setTitle("Connected", forState: UIControlState.Normal)
        }
        detailTableView.reloadData()
    }
    
    func loadRetailerData(){
        
        var setAmount = 0
        var setPoint = 0
        
        print("Seesion key:",UserModel.getUserSessionKey())
        
        
        var dictData : AnyObject!
        
        let data = self.response.objectForKey("retailer") as! NSDictionary
                 print("Data From Retailer", data)
        dictData = data.objectForKey("business") as! NSDictionary
        
         print("Welcome",dictData)
        
        retailersImage!.downloadedFrom(link: dictData.objectForKey("profilePic") as! String)
        retailersName?.text = dictData.objectForKey("name") as? String
        retailersAddress?.text = dictData.objectForKey("business_address") as? String
        setNavigationTitleText((retailersName?.text)!)
        
        dictData = data.objectForKey("customer") as! NSDictionary
        
        points?.text = dictData.objectForKey("totalPoints") as? String
        // Working for Setamount
        
        let setPrice = self.response.valueForKey("retailer") as? NSDictionary
        
        print(setPrice?.allKeys)
        
        for (key, value) in setPrice!{
        
            if key as! String == "setAmount"{
                 print("setAmount:\(value)")
                setAmount =  (value as! NSString).integerValue
             
            
            }
            
            if key as! String == "haveCustomReward"{
                print("haveCustomReward: \(value)")
            
            }
            
            if key as! String == "setPoint"{
                print("setPoint:\(value)")
                setPoint =   (value as! NSString).integerValue
            }
            
        }
        
        
        lblAmountAndPoints.text = "Rs.\(String(setAmount)) = \(String(setPoint)) Points"
        
        

        
//        print(" SetAmount Print" ,self.response.objectForKey("bonusReward") as? NSDictionary)
//        print("setPoint\(data.objectForKey("setPoint") as? Int)")
//     
        // Set amount
        
        
        
        _userTotalPoints = StringUtil.getNumebrFromString((points?.text)!)
        totalVisit?.text = dictData.objectForKey("totalVisits") as? String
        
        retailerID = dictData.objectForKey("business_id") as? String
        
        dictData = data.objectForKey("offers") as! NSDictionary
        activeOffer?.text = "\(dictData.objectForKey("activeOfferCount") as! NSNumber)";
        
        dictData = data.objectForKey("bonusReward") as! NSArray
        
        _bonusRewardCount = dictData.count
        
        let strikeThrough = [NSUnderlineStyleAttributeName: 1]
        
        if _bonusRewardCount != 0{
        
        let attrStr = NSMutableAttributedString(string: "You have  \(_bonusRewardCount) unclaimed bonus reward");
        attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
        bonusRewards!.attributedText = attrStr
        lblbonusAwards.text = String(dictData.count)
        }else{
        
            let attrStr = NSMutableAttributedString(string: "view unclaimed reward");
            attrStr.addAttributes(strikeThrough, range: NSMakeRange(0,attrStr.length))
            bonusRewards!.attributedText = attrStr
            lblbonusAwards.hidden = true
        }
        
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if tableView == alertTableView{
            return 60
        }
        return 0
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if tableView == alertTableView {
            
            return alertTableFooterView
        }
        
        return UIView()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight = SizeUtil.convertIphone6ToIphone5(45);
        
        if tableView == alertTableView {
            rowHeight = 70;
        }
        return rowHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == alertTableView{
            
            if _retailerFBRewardDetail.allKeys.count != 0 {
                    return self._retailerFBRewardDetail.allKeys.count - 1;
            }
            return 0

        }
        
        let arrayAwards:NSArray = (self.response.valueForKey("retailer")?.objectForKey("loyaltyReward"))! as! NSArray;
        
        
        
        return arrayAwards.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == alertTableView{
        let cell = tableView.dequeueReusableCellWithIdentifier("detail_alert_cell", forIndexPath: indexPath) as! DetailAlertTableViewCell
            if _retailerFBRewardDetail.allKeys.count != 0 {
                cell.setCellData(_retailerFBRewardDetail, pageData: _retailerPageDetail, index: indexPath.row)
            }
            
            cell.selectionStyle = .None
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! RetailersDetailViewCell
        
        let arrayAwards:NSArray = (self.response.valueForKey("retailer")?.objectForKey("loyaltyReward"))! as! NSArray;
         //  print(self.response.valueForKey("retailer")?.objectForKey("loyaltyReward")?.objectForKey("setAmount") as? Int )
        
             print(arrayAwards[indexPath.row].valueForKey("setAmount") as? Int)
        
        
        
        cell.pointsNeeded?.text = arrayAwards[indexPath.row].valueForKey("pointsNeeded") as? String;
        cell.pointsRewards?.text = arrayAwards[indexPath.row].valueForKey("rewardValue")as? String;
        if (arrayAwards[indexPath.row].valueForKey("rewardValue")as? String)! == "0"{
               cell.pointsRewards?.text = "No any Awards"
        
        
        }
        let point = StringUtil.getNumebrFromString((arrayAwards[indexPath.row].valueForKey("pointsNeeded") as? String)!);
        cell.pointsNeeded?.textColor = UIColor.redColor()
        if point < _userTotalPoints{
            cell.backgroundColor = UIColor.perkupTableGreen()
            cell.pointsNeeded?.textColor = UIColor.perkupGreen()
        }
        cell.selectionStyle = .None
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == alertTableView{
            if indexPath.row == 0{
                HelperUtil.openUrl("\(Constant.fblikeUrl)\(self._retailerPageDetail.valueForKey("fbPageId") as! String)")
            }
            
        }
    }
    
    @IBAction func didTapOnCrossBtn(sender: AnyObject) {
        
        alertView.hidden = true;
    }
    
    
    @IBAction func didTapOnFBLike(sender: AnyObject) {
        
        alertView.hidden = false
        
        if UserModel.isConnectedFromFb(){
            self.fetchRewardData();
        }
        
    }
    
    @IBAction func didTapOnBonusReward(sender: AnyObject) {
        
//        if _bonusRewardCount <= 0 {
//            
//          // Alert.showAlert("Info", message: "You don not have any Bonus Reward");
//            //self.performSegueWithIdentifier("sw_bonus", sender: self)
//
//           // return;
//            
//        }
        
        
        let dict = [
            "access_token":UserModel.getUserToken(),
            "business_id": self.response.valueForKey("retailer")!.valueForKey("customer")!.valueForKey("business_id") as! String];
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()];
        
        print(header);
        ServiceWrapper.myRewardsWithBusinessID( (self.response.valueForKey("retailer")!.valueForKey("customer")?.valueForKey("business_id"))! as! NSString, header: header, requestObject: dict) { (success, response) -> Void in
            if (success) {
                
                
                 self.reObj.setDatafromServer(response )
                
                NSLog(" hahahahah %@", response);
                
                
                self.bonusResponse = response.valueForKey("rewards") as! NSArray?;
                self.retailer = response.valueForKey("retailer") as! NSDictionary?;
                
                self.performSegueWithIdentifier("sw_bonus", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "sw_bonus" ) {
            
            if let bonusViewController = segue.destinationViewController as? BonusRewardsViewController {
                bonusViewController.response = self.bonusResponse;
                // changing by ayaz
                bonusViewController.retailers = self.retailer
                bonusViewController.retailerObject = self.reObj
                
                 print("contact number")
                bonusViewController._retailerName = retailersName?.text
            }
        }
    }
    
    @IBAction func didTapOnFbConnect(sender: AnyObject) {
        
        if UserModel.isConnectedFromFb(){
            Alert.showAlert("", message: "Already Connected");
            return
        }
        connectWithFacebook()
    }
    
    
    func connectWithFacebook(){
        
        loginWithFacebook(self) { (success, response, error) -> Void in
            
            
            if (success){
                self.postUserFBDetail(response as! NSDictionary);
            }else{
                print(error)
            }
        }
    
        
    }
    
    
    func postUserFBDetail(response:NSDictionary){
        
        
        let dict  : NSDictionary = ["fbUser_id":response.objectForKey("id") as! String,
            "fb_code":FBSDKAccessToken.currentAccessToken().tokenString,
            "access_token":UserModel.getUserToken()
        ]
        
        print(dict);
        
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()];
        ServiceWrapper.postUserFBDetail(header, requestObject: dict, completionHandler: { (success, response) -> Void in
            print(response)
            
            UserModel.setConnectedFromFb(true);
            self.btnConnectWithFb.setImage(nil, forState: UIControlState.Normal);
            self.btnConnectWithFb.setTitle("Connected", forState: UIControlState.Normal)
            self.fetchRewardData()
        })
        
        
        
    }
    func fetchRewardData(){
        
        let dict = [
            "access_token":UserModel.getUserToken(),
            "business_id": self.response.valueForKey("retailer")!.valueForKey("customer")!.valueForKey("business_id") as! String];
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()];
        
        ServiceWrapper.getOfferToEarnPoints( (self.response.valueForKey("retailer")!.valueForKey("customer")?.valueForKey("business_id"))! as! NSString, header: header, requestObject: dict) { (success, response) -> Void in
            if (success) {
                
                
                NSLog("%@", response);
                
                if let facebookDetail = response.objectForKey("facebook") as? NSDictionary{
                 
                    self._retailerFBRewardDetail = facebookDetail;
                }
                if let facebookPageDetail = response.objectForKey("facebookPage") as? NSDictionary{
                    
                    self._retailerPageDetail = facebookPageDetail
                }
                
                
                self.alertTableView.reloadData();
                
            }
        }
        
    }
    
    
    func loginWithFacebook(viewController:UIViewController,
        completionHandler:(success:Bool,response:AnyObject,error:ErrorType?)->Void){
            
            let login = FBSDKLoginManager()
            login.logInWithReadPermissions(["public_profile","email","user_friends","user_likes"], fromViewController: viewController) { (result, error) -> Void in
                
                if error != nil {
                    print("error")
                    completionHandler(success: false, response:"", error:error)
                    
                }
                else if(result.isCancelled){
                    print("result cancelled")
                    completionHandler(success: false, response:result, error:error)
                }
                else{
                    print("success Get user information.")
                    
                    let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters:["fields":"picture, email,name"]);
                    fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                        
                        if error == nil
                        {
                            print("User Info : \(result)")
                            
                            completionHandler(success: true, response:result, error:error)
                        }
                        else
                        {
                            print("Error Getting Info \(error)");
                            completionHandler(success: false, response:result, error:error)
                        }
                        
                    }
                }
                
            }
            
            
    }
    
       // Receive action
    func labelAction(gr:UITapGestureRecognizer)
    {
        
        let offer = Offer()

        
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            return
        }
        
        
        
        
        
      //  Alert.showLoader("Loading.....")
        
        
        
        
        let dict = ["type":"retailer",
                    "type_id":retailerID]
        
        ServiceWrapper.getFeaturedOffer("\(Constant.baseUrlForOffer)offers",header: ["":""], params: dict) { (success, response) -> Void in
            if (success){
                
                
                if let dataArray = response.objectForKey("offer") as? NSArray{
                    
                         print(" Response",response.allKeys)
                    //Mark : Show Message when no deal found
                    if dataArray.count == 0{
                       // self.lblInfo.hidden = false
                        Alert.showAlert("Active Offers", message:"You have no any active offer")
                        return
                    }
                   // self._allOfferArray.removeAllObjects()
                    for item in dataArray{
                        offer.setDatafromServer(item as! NSDictionary)
                        print("Offer Detail",offer.business_id)
                        //self._allOfferArray.addObject(offer)
                        
                        
                        
                    }
                 //   self.allOfferTableView.reloadData()
                    let storyBoard = UIStoryboard.init(name:"Main", bundle:nil)
                    let allOfferController = storyBoard.instantiateViewControllerWithIdentifier("AllOffersController") as! AllOffersController
                         allOfferController.passedId = offer.business_id
                         allOfferController.passedBusinessName = offer.business_name
                    
                    
                    self.navigationController?.pushViewController(allOfferController, animated: true)
                        
                
                   // self.presentViewController(allOfferController, animated: true, completion:nil)
                }
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }

    
        

        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func setDesignForNewView(){
        /* v3*/
        lblYouHave.adjustsFontSizeToFitWidth = true
        lblRsV3.adjustsFontSizeToFitWidth = true
        lblOnYourV3.adjustsFontSizeToFitWidth = true
        lblYouCanV3.adjustsFontSizeToFitWidth = true
        lblPoints.adjustsFontSizeToFitWidth = true
        /*    v2   */
         lblEarn.adjustsFontSizeToFitWidth = true
         lblEarnRs.adjustsFontSizeToFitWidth = true
         lblRedeem.adjustsFontSizeToFitWidth = true
         lblforThat.adjustsFontSizeToFitWidth = true
         lblExpendRs.adjustsFontSizeToFitWidth = true
         lblForEvery.adjustsFontSizeToFitWidth = true
         lblForEvery2.adjustsFontSizeToFitWidth = true
        
        
        
        
        
    }
    
    
    
}