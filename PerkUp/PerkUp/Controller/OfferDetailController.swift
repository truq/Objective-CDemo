//
//  OfferDetailController.swift
//  PerkUp
//
//  Created by NGI-Noman on 04/04/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit
import MessageUI
import Social



class OfferDetailController: BaseController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,TruqDropDownDelegate,PerkupAlertViewDelegate, UITableViewDelegate, UITableViewDataSource,MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, FBSDKSharingDelegate,FBSDKAppInviteDialogDelegate{
    
    // IBoutlets for the share
    
    @IBOutlet weak var shareAlertTop: NSLayoutConstraint!
    @IBOutlet weak var lblShareHeading: UILabel!
    @IBOutlet weak var lblShareDescription: UILabel!
    @IBOutlet weak var viewPromotionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textVeiwHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txtViewTermsHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTermsHeight: NSLayoutConstraint!
    //End
    
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet var viewForCollection: UIView!
    
    @IBOutlet weak var viewYESNO: UIView!
    @IBOutlet weak var viewBlack: UIView!
    @IBOutlet weak var viewAlertShare: UIView!
    
    
//    let loginButton: FBSDKLoginButton = {
//        let button = FBSDKLoginButton()
//        button.readPermissions = ["email"]
//        return button
//    }()
    
    
    /// ayaz akbar
    var seconds = 0
    var minutes = 0
    var hours = 0
    var days = 0
    let currentDate = NSDate()
    var isTapOnShareBtn: Bool!
    //ayaz
    
    
    
    var _daysStr = ""
    var _hourStr = ""
    var _minuteStr = ""
    var _secondsStr = ""
    var msg: String!

    @IBOutlet var mainContentView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var offerDetailCollectionView: UICollectionView!
    @IBOutlet weak var txtViewAboutOff: UITextView!
    @IBOutlet weak var txtViewTermACond: UITextView!
    
    
    @IBOutlet weak var btnShowImages: UIButton!
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    
    @IBOutlet weak var lblRemainingCounter: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var btnSavedOffer: UIButton!
    @IBOutlet weak var btnSharedOffer: UIButton!
    
    @IBOutlet weak var lblInviteDesription: UILabel!
    
    @IBOutlet weak var btnInviteFriend: UIButton!
    @IBOutlet weak var btnAboutThisPromotion: UIButton!
    
    @IBOutlet weak var btnTermCondition: UIButton!
    
    @IBOutlet weak var lblRemainOfferTime: UILabel!
    @IBOutlet weak var btnBookIt: UIButton!
    
    @IBOutlet weak var btnYES: UIButton!
    @IBOutlet weak var lblYESNO: UILabel!
    var lblCounter : UILabel!
    
    @IBOutlet weak var btnNO: UIButton!
    @IBOutlet weak var viewAlertYESNO: UIView!
    
    @IBOutlet weak var btnCloseYESNO: UIButton!
    var dropDownPromotion:TruqDropDown!
    var dropDownTerms:TruqDropDown!
    var popUpImageView:UIImageView!
    var _offer : Offer!
    var _galleryCollection : NSArray = NSArray()
    var _alertView : PerkupAlertView!
    var isDropDownOpen = false
    
    
    var arrayOfShareOnApps: NSArray!
    var arrayOfImages: NSArray!
    
    //Mark : OutletCollections
    
    @IBOutlet var labelsCollection: [UILabel]!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var dropDownCollection: [UIButton]!
    
    @IBOutlet weak var viewPromotions: UIView!
    @IBOutlet weak var viewTermsAndCond: UIView!
    
    //Mark : NsLayOutConstraint
    @IBOutlet weak var topTremsAndCondition: NSLayoutConstraint!
    @IBOutlet weak var topFooterView: NSLayoutConstraint!
    
    @IBOutlet weak var promotionHeight: NSLayoutConstraint!
    @IBOutlet weak var termsConditionHeight: NSLayoutConstraint!
    
    
    
    // Alert Table View
    
    
    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var tableShare: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
       
        print("Data",_offer.sharing_url, _offer.sharing_subject, _offer.sharing_message, "Friends discount:\(_offer.friend_discount)", _offer.is_inviteable)
        
        arrayOfShareOnApps = ["Facebook","WhatsApp","Mail","SMS"]
        arrayOfImages = ["fbImage","whatsapp","mail","sms"]
        //ayaz
        tableShare.registerNib(UINib(nibName: "ShareTableViewCell", bundle: nil), forCellReuseIdentifier: "ShareTableViewCell")

        
        //whatsup
        let whatsUp: NSURL = NSURL(string: String(format: "whatsapp://"))!
        let isWhatsUpInstalled = UIApplication.sharedApplication().canOpenURL(whatsUp)
        
        if isWhatsUpInstalled{
              print("Whatsapp installed")
        }else{
            print("Whatsapp not installed")
        }
        
        // facebook
        let urlPath: String = "fb://"
        let url: NSURL = NSURL(string: urlPath)!
        let isInstalled = UIApplication.sharedApplication().canOpenURL(url)
        
        if isInstalled {
            print("facebook installed")
        }else{
            print("facebook not installed installed")
        }
        

        
        if (_offer.is_inviteable != true){
            btnInviteFriend.hidden = false
        }
        
        
        print(_offer.on_going);
        
        customizeUI();
        addRightButton();
        setOfferData();
        addLeftButton();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnInviteButton() {
        print("Invite")
        
         btnSharedOffer.tag = 200
        viewAlertShare.frame = CGRectMake(0, 64, self.view.frame.size.width,SizeUtil.convertIphone6ToIphone5(self.view.frame.height))
        
        viewAlertShare.backgroundColor = UIColor.alertBGColor()
        self.view.addSubview(viewAlertShare)
//        self.viewAlertShare.hidden = false
    }
    
    
    
    
    @IBAction func didTapOnBookItBtn(sender: AnyObject) {
        
        if !UserModel.isUserLoggedIn(){
            
            
            AppDelegate.getInstatnce().createAlertView()
            print("Show alert view")
            return
        }
        
                viewAlertYESNO.hidden = false
        
        
        
    }
    
    @IBAction func didTapOnSaveOffer(sender: AnyObject) {
        
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            print("Save Button is Pressed")

            return
        }
        
        
        
       // btnSharedOffer.tag = 200
        
          self.saveOffer();
    }
    
    
    
    
    
    
    
    
    func customizeUI() {
        
        
    lblShareHeading.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5(20))
        
        lblShareDescription.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5(13))
        
        
        mainContentView.frame = CGRectMake(0, 0, self.view.frame.size.width,SizeUtil.convertIphone6ToIphone5(mainContentView.frame.height));
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, mainContentView.frame.height)
        mainScrollView.addSubview(mainContentView)
        offerDetailCollectionView!.registerNib(UINib(nibName: "OfferDetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "OfferDetailCollectionCell")
     //   offerDetailCollectionView!.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        btnBookIt.frame = CGRectMake(SizeUtil.convertIphone6ToIphone5(205), SizeUtil.convertIphone6ToIphone5(22), SizeUtil.convertIphone6ToIphone5(150), SizeUtil.convertIphone6ToIphone5(46))
        
        viewAlertYESNO.frame = CGRectMake(0, 64, self.view.frame.size.width,SizeUtil.convertIphone6ToIphone5(self.view.frame.height))

        viewYESNO.layer.cornerRadius = Constant.CommonRadius
        viewAlertYESNO.backgroundColor = UIColor.alertBGColor()
        btnNO.layer.cornerRadius = Constant.CommonRadius
        btnYES.layer.cornerRadius = Constant.CommonRadius
        self.view.addSubview(viewAlertYESNO)
        viewAlertYESNO.hidden = true
        
        
        
        
        
        
        for label in labelsCollection{
            label.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5((label.font?.pointSize)!));
            
        }
        for button in buttonCollection{
            button.titleLabel?.font = UIFont(name: Constant.AppFontRegular, size:SizeUtil.convertIphone6ToIphone5((button.titleLabel?.font.pointSize)!))
            button.layer.cornerRadius = Constant.CommonRadius + 4
          
            
            if button.tag == 998 || button.tag == 999{
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 2, 0);button.layer.borderWidth = 0
                button.layer.cornerRadius = 6
                button.backgroundColor = UIColor.clearColor()
                button.layer.borderColor = UIColor.perkupGreen().CGColor
                button.titleLabel?.font = UIFont(name: Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(17))
            }
        }
        
        btnInviteFriend.backgroundColor = UIColor.perkupBlue()
      //  customizeDropDownButton()
    }
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
       // viewBlack.hidden = true
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRectMake(0,0,self.view.frame.size.width - 20
,SizeUtil.convertIphone6ToIphone5(240))
        gradient.startPoint = CGPointMake(0, 0.4);
        gradient.endPoint = CGPointMake(0, 1);
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        imgBanner.layer.insertSublayer(gradient, atIndex: 0)
        imgBanner.contentMode = UIViewContentMode.ScaleToFill
        imgBanner.autoresizingMask = [
                 .FlexibleBottomMargin,
                 .FlexibleHeight
                ,.FlexibleLeftMargin
                ,.FlexibleRightMargin
                ,.FlexibleTopMargin
                ,.FlexibleWidth];
        
        
        
        lblCounter.text = "\(UserModel.getUserDealCount())"
        self.lblCounter.hidden = false
        if UserModel.getUserDealCount() < 1 {
            self.lblCounter.hidden = true
        }
        
    }
    func setOfferData(){
        
        let  aboutOffer = try! NSAttributedString(data: _offer.about!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        let termsAndCond = try! NSAttributedString(data:_offer.terms!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
                                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                          documentAttributes: nil)
        
        
        lblRemainingCounter.text = "Only \(_offer.offer_available!) Left"
        lblTitle.text = _offer.business_name!
        lblDescription.text = _offer.offer_title!
        lblAddress.text = _offer.locality
       
        txtViewTermACond.attributedText = termsAndCond
        txtViewAboutOff.attributedText = aboutOffer
        
        print("about offer length",aboutOffer.length)
        
        if Devices.DeviceType.IS_IPHONE_4_OR_LESS
        {
         textVeiwHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewAboutOff.contentSize.height - 40)
         viewPromotionHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewAboutOff.contentSize.height )
            
            /*   View Terms */
            txtViewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermACond.contentSize.height - 40)
            viewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermACond.contentSize.height )
            
        
        }else if Devices.DeviceType.IS_IPHONE_5
        {
        
            textVeiwHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewAboutOff.contentSize.height)
            viewPromotionHeight.constant += SizeUtil.convertIphone6ToIphone5(textVeiwHeight.constant)
            /*   View Terms */

            txtViewTermsHeight.constant += txtViewTermACond.contentSize.height
            viewTermsHeight.constant += txtViewTermsHeight.constant
            
            
        
        }else if Devices.DeviceType.IS_IPHONE_6
        {
            textVeiwHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewAboutOff.contentSize.height - 66)
            viewPromotionHeight.constant += SizeUtil.convertIphone6ToIphone5(textVeiwHeight.constant - 66)
            txtViewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermACond.contentSize.height)
            viewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermsHeight.constant - 66)
            
        }else{
            
            textVeiwHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewAboutOff.contentSize.height - 66)
            
            viewPromotionHeight.constant += SizeUtil.convertIphone6ToIphone5(textVeiwHeight.constant - 66)
            
            txtViewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermACond.contentSize.height)
            viewTermsHeight.constant += SizeUtil.convertIphone6ToIphone5(txtViewTermsHeight.constant - 66)
        
        }
        


        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, mainScrollView.contentSize.height + textVeiwHeight.constant + txtViewTermsHeight.constant - 100 )
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainScrollView.setNeedsLayout()
            self.mainScrollView.layoutIfNeeded()
            
        })

        
        
        
        
        
        
        
        imgBanner.downloadedFrom(link: _offer.offer_image!)
        
        if _offer.gallery?.count == 0{
        
           btnShowImages.hidden = true
        }
        
        
        // Time lbl setting code
        
        
        if let offer_nature = _offer.offer_nature_value{
            
            if let offer_nature_value = offer_nature.objectForKey("offerNatureValue") as? String{
                
                lblInviteDesription.text = offer_nature_value
            }
        }
        
        
        
        
        if _offer.on_going!  {
            lblTime.hidden = true
            lblRemainOfferTime.text = "LIMITED TIME "
        }
        else{
            
            
                   lblTime.hidden = false
                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(timer), userInfo:nil, repeats: true)
        }
        

        
        if _offer.expiry_date != ""{
            
            
            let systemDate = NSDate()
            // let offerDate  = _offer.expiry_date
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let date = dateFormatter.dateFromString(_offer.expiry_date!)
            
            
            
            let offerDate = systemDate.timeIntervalSince1970 < date!.timeIntervalSince1970
            
            print("offer date",offerDate)
            
            
            if offerDate{
                
                btnBookIt.userInteractionEnabled = true
                print("Time is Remaining")
                
            }else{
                
                btnBookIt.userInteractionEnabled = false
                lblRemainOfferTime.text = "Offer Expired"
                lblTime.hidden = true
                print("Time is Expired")
            }
            
            
            
        }
        

        
        
        
        _galleryCollection = _offer.gallery!
        offerDetailCollectionView.reloadData()
        
        
        
        
        
        
        
    }
    
    override func addRightButton() {
        
        let rightButtonCart = UIButton(frame: CGRectMake(0, view.center.y, 40, 40))
        rightButtonCart.center.y = view.center.y
        rightButtonCart.setImage(UIImage(named: "cart-icon"), forState: UIControlState.Normal)
        rightButtonCart.addTarget(self, action: #selector(OfferDetailController.didTapOnCartButton), forControlEvents: UIControlEvents.TouchUpInside);
        
        
        let rightButtonAllOffer = UIButton(frame: CGRectMake(0, view.center.y, 200, 25))
        rightButtonAllOffer.center.y = view.center.y
        rightButtonAllOffer.setTitle("View All Offer From \(_offer.business_name!)", forState: UIControlState.Normal);
        rightButtonAllOffer.titleLabel?.font = UIFont(name:Constant.AppFontRegular, size: SizeUtil.convertIphone6ToIphone5(15));
        rightButtonAllOffer.addTarget(self, action: #selector(OfferDetailController.didTapOnAllOfferButton), forControlEvents: UIControlEvents.TouchUpInside);
        rightButtonAllOffer.layer.borderWidth = 1
        rightButtonAllOffer.layer.cornerRadius = Constant.CommonRadius
        rightButtonAllOffer.layer.borderColor = UIColor.whiteColor().CGColor
        rightButtonAllOffer.titleLabel!.textAlignment = NSTextAlignment.Center
        rightButtonAllOffer.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 3, 3);
        rightButtonAllOffer.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        lblCounter = UILabel(frame: CGRectMake(25,0,13,13))
        lblCounter.backgroundColor = UIColor.redColor();
        lblCounter.text = "\(UserModel.getUserDealCount())"
        lblCounter.textColor = UIColor.whiteColor()
        lblCounter.layer.cornerRadius = 13/2
        lblCounter.layer.masksToBounds = true
        lblCounter.clipsToBounds = true
        lblCounter.textAlignment = NSTextAlignment.Center
        lblCounter.font = UIFont(name: Constant.AppFontRegular, size: 11)
        rightButtonCart.addSubview(lblCounter)
      
        let barButtonCart = UIBarButtonItem(customView: rightButtonCart)
        let barButton = UIBarButtonItem(customView: rightButtonAllOffer)
        
        self.navigationItem.rightBarButtonItems = [barButtonCart, barButton/* this will be the button which you actually need */]
        
    }
    
    func didTapOnAllOfferButton(){
        
        
        
        
        
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            return
        }
        
        self.performSegueWithIdentifier(Constant.sw_pushtoalloffer, sender: self);
        
    }
    func didTapOnCartButton(){
        
        if !UserModel.isUserLoggedIn(){
            AppDelegate.getInstatnce().createAlertView()
            return
        }
        
        self.performSegueWithIdentifier(Constant.sw_pushtobookedoffer, sender: self);

    }
    
    @IBAction func didTapOnPromotions(sender: AnyObject) {
        
        
        var dropDownheight = self.view.frame.size.height - viewPromotions.frame.origin.y - viewPromotions.frame.size.height

        if(dropDownPromotion == nil) {
//            isDropDownOpen = true
            dropDownPromotion = TruqDropDown()
            dropDownPromotion.showDropDownWithTextView(sender as! UIButton, height: dropDownheight, textString:_offer.about!, direction: "down")
            dropDownPromotion.customDelegate = self
            mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, mainScrollView.contentSize.height + textVeiwHeight.constant)
            
            self.promotionHeight.constant += dropDownheight
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.mainScrollView.setNeedsLayout()
                self.mainScrollView.layoutIfNeeded()
            
            })

        }
        else {
            dropDownheight = self.view.frame.size.height - viewPromotions.frame.origin.y - btnAboutThisPromotion.frame.size.height
            
            dropDownPromotion.hideDropDownTextView(sender as! UIButton)
            mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, mainScrollView.contentSize.height - dropDownheight)
            
            self.promotionHeight.constant -= dropDownheight
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.mainScrollView.setNeedsLayout()
                self.mainScrollView.layoutIfNeeded()
                
            })
//            isDropDownOpen = false
            dropDownPromotion = nil
        }
    }
    
    @IBAction func didTapOnTermsAndCond(sender: AnyObject) {
        
        
        var dropDownheight = self.view.frame.size.height - viewTermsAndCond.frame.origin.y - viewTermsAndCond.frame.size.height
        
        if(dropDownTerms == nil) {
            isDropDownOpen = true
            dropDownTerms = TruqDropDown()
            dropDownTerms.showDropDownWithTextView(sender as! UIButton, height: dropDownheight, textString: _offer.terms!, direction: "down")
            dropDownTerms.customDelegate = self
            
           self.termsConditionHeight.constant += dropDownheight
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.mainScrollView.contentSize.height + dropDownheight)
                
                self.mainScrollView.setNeedsLayout()
                self.mainScrollView.layoutIfNeeded()
                
            })
            
        }
        else {
            
            dropDownheight = self.view.frame.size.height - viewTermsAndCond.frame.origin.y - btnTermCondition.frame.size.height
            
            
            dropDownTerms.hideDropDownTextView(sender as! UIButton)
            mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, mainScrollView.contentSize.height - dropDownheight)
            
            self.termsConditionHeight.constant -= dropDownheight
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
              
                self.mainScrollView.setNeedsLayout()
                self.mainScrollView.layoutIfNeeded()
                
              
            })
            
            dropDownTerms = nil
        }
        
        print(mainScrollView.contentSize)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return _galleryCollection.count
    }
    
    
    func collectionView(collectionView: UICollectionView,cellForItemAtIndexPath indexPath: NSIndexPath) ->
        UICollectionViewCell {
            
            //let reuseIdentifier = "collection\(indexPath.row)"
            
            print("Collection view is Called")
            
            
            var cell : OfferDetailCollectionCell? = collectionView.dequeueReusableCellWithReuseIdentifier("OfferDetailCollectionCell",
                forIndexPath: indexPath) as? OfferDetailCollectionCell
            if  (cell==nil){
                let nib:NSArray=NSBundle.mainBundle().loadNibNamed("OfferDetailCollectionCell", owner: self, options: nil)
                
                cell = nib.objectAtIndex(0) as? OfferDetailCollectionCell
            }
            
            if _galleryCollection.count != 0{
                
                cell?.setCellImageData(_galleryCollection.objectAtIndex(indexPath.row) as! String);
                
            }
            
            return cell!
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = SizeUtil.convertIphone6ToIphone5(340)
        
        return CGSizeMake(size, size);
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        let SelectedCell =  collectionView.cellForItemAtIndexPath(indexPath) as! OfferDetailCollectionCell
//        
//        popUpImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width*0.4, self.view.frame.size.width*0.4));
//        popUpImageView.center.x = self.view.center.x;
//        popUpImageView.center.y = offerDetailCollectionView.center.y
//        popUpImageView.userInteractionEnabled = true
//        
//        popUpImageView.image = SelectedCell.image.image
//        self.mainScrollView.addSubview(popUpImageView)
//        
////        let button = UIButton(frame:CGRectMake(popUpImageView.frame.size.width-10,-10,20,20));
////        button.setImage(UIImage(named: "close-white"), forState: UIControlState.Normal)
////        button.addTarget(self, action: #selector(OfferDetailController.removePopUpImage), forControlEvents: UIControlEvents.TouchUpInside);
////        button.userInteractionEnabled = true;
////        popUpImageView.addSubview(button);
////        
//        
//        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
//           self.popUpImageView.transform = CGAffineTransformMakeScale(2, 2)
//            }, completion: { finished in
//
//        })
        
    }
    
    func removePopUpImage(){
        
        UIView.animateWithDuration(0.9, delay: 0.0, options: .CurveEaseIn, animations: {
            self.popUpImageView.transform = CGAffineTransformMakeScale(0, 0)
            }, completion: { finished in
                
                self.popUpImageView = nil
                
        })
        
    }
    
//    func customizeDropDownButton(){
//        
//        for btnDropDown in dropDownCollection{
//            btnDropDown.layer.shadowOpacity = 0.5
//            btnDropDown.layer.shadowOffset =  CGSizeMake(0, 1);
//            
//            btnDropDown.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//            btnDropDown.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//            btnDropDown.titleLabel?.adjustsFontSizeToFitWidth = true
//        }
//        
//    }
    func setTitleLabel() {
        //
    }
    
    func bookOffer(){
        
        
        print( " Deal Count ",UserModel.getUserDealCount())
        
        if UserModel.getUserDealCount() >= 3 {
            
                 print("you could not book offers")
        }
        
        let dict = ["offer_id":_offer.offer_id!,
        "access_token":UserModel.getUserToken()]
        
        
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        ServiceWrapper.bookOffer("\(Constant.baseUrlForSecure)booking",header: header, requestObject:dict) { (success, response) -> Void in
            
            if (success){
                
                print(response,"Booking response");
                print("usercount\(UserModel.getUserDealCount())")
                
                if UserModel.getUserDealCount() < 3{
                    
                    UserModel.saveUserDealCount( UserModel.getUserDealCount() + 1)
                    self.lblCounter.text = "\(UserModel.getUserDealCount())"
                    self.lblCounter.hidden = false
                    self.createAlertView("You have booked offer Successfully", btnTitleText: "Booked Offer")
                }
                
                
            }
            else{
                
                
                if let error = response.objectForKey("message") as? String{
                    // constant hardcode String 
                    _ = "You have booked 3 offers. Redeem or cancel booked offer before you can book more. "
                    // string at the place of error
                    self.createAlertView(error, btnTitleText: "Booked Offers")
                }
                
            }
        }
       
        
        
        
    }
    
    func saveOffer(){
        
        let dict = ["favoriteObjectId":_offer.offer_id!,
            "access_token":UserModel.getUserToken(),
        "favoriteType":"USER_FAVORITE_TYPE_OFFER"]
        
        let header = [
            "sessionkey":UserModel.getUserSessionKey()]
        
        ServiceWrapper.bookOffer("\(Constant.baseUrlForSecure)userfavorites",header: header, requestObject:dict) { (success, response) -> Void in
            
            if (success){
                
                print("Response....",response);
                Alert.showAlert("", message: "Offer Saved Successfully")
                
            }
            else{
                Alert.showAlert("", message: "Network Problem")
            }
        }
        
    }
//
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( segue.identifier == Constant.sw_pushtoalloffer ) {
            
            if let destinationController = segue.destinationViewController as? AllOffersController{
                destinationController._offer = self._offer
            }
            
        }
        
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
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("BookedDetailController") as! BookedDetailController
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func timer(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.dateFromString(_offer.expiry_date!)
        
        let start = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let datecomponenets = calendar.components([.Second, .Hour,.Minute, .Day], fromDate: start, toDate: date!, options:[])
        self.seconds = datecomponenets.second
        _secondsStr = "\(seconds)"
        self.hours = datecomponenets.hour
        _hourStr = "\(hours)"
        self.minutes = datecomponenets.minute
        _minuteStr = "\(minutes)"
        self.days = datecomponenets.day
        _daysStr = "\(days)"
        
        
        
        
        //lblRemainOfferTime.text = "ONGOING"
        
        var str:NSMutableAttributedString!
        
        var string = ""
        
        if self.days<10{
            _daysStr = "0\(days)"
        }
        if self.hours < 10 {
            _hourStr = "0\(hours)"
        }
        if minutes < 10 {
            _minuteStr = "0\(minutes)"
        }
        if seconds < 10 {
            _secondsStr = "0\(seconds)"
            
        }
        
        
        
        
        
        if _daysStr <= "1"{
            
            string = "\(_daysStr) Day \(_hourStr):\(_minuteStr):\(_secondsStr)"

        }else{
            string = "\(_daysStr) Days \(_hourStr):\(_minuteStr):\(_secondsStr)"

        
        }
        
        if datecomponenets.minute < 0{
        
            print("value in minus")
        
        }else{
        
           print("value in plus")
        
        }
        
        
        
        
        
        
        str = NSMutableAttributedString(string: string);
        
//        let startRange = NSMakeRange(0, 7)
//        let midRange = NSMakeRange(8, 8)
//        let endRange = NSMakeRange(16, 12)
//        str.beginEditing()
//        str.addAttribute(NSFontAttributeName, value:UIFont(name: Constant.AppFontRegular,size:(lblRemainOfferTime?.font.pointSize)!)!, range: startRange);
//        str.addAttribute(NSFontAttributeName, value:UIFont(name: Constant.AppFontBold,size:(lblRemainOfferTime?.font.pointSize)!)!, range: midRange);
//        str.addAttribute(NSFontAttributeName, value:UIFont(name: Constant.AppFontRegular,size:10)!, range: endRange);
//        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range:endRange)
//        str.endEditing()
        lblTime.text = string
        
        
    }
    
    
    @IBAction func didTapOnShare(){
          print("didTap Called")
         btnSharedOffer.tag = 100
        
        viewAlertShare.frame = CGRectMake(0, 64, self.view.frame.size.width,SizeUtil.convertIphone6ToIphone5(self.view.frame.height))
        
        if Devices.DeviceType.IS_IPHONE_4_OR_LESS{
        
          shareAlertTop.constant = 20
        
        }
        
        
        
        viewAlertShare.backgroundColor = UIColor.alertBGColor()
        self.view.addSubview(viewAlertShare)
        self.viewAlertShare.hidden = false
    }
    
    @IBAction func didTapOnClose(){
        self.viewAlertShare.hidden = true
    
    }
    
    // tableview delegation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfShareOnApps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ShareTableViewCell = tableShare.dequeueReusableCellWithIdentifier("ShareTableViewCell") as! ShareTableViewCell
        
        if (btnSharedOffer.tag == 100){
            // share button created
            cell.setSelected(false, animated: false)
            cell.btnCellShare.hidden = true
            cell.labelCellTitle.text = arrayOfShareOnApps.objectAtIndex(indexPath.row) as? String
            cell.imageCellShare.image = UIImage(named: arrayOfImages.objectAtIndex(indexPath.row) as! String)
        return cell
        }else{
            // invite cell created
        cell.btnCellShare.hidden = false
        cell.labelCellTitle.text = arrayOfShareOnApps.objectAtIndex(indexPath.row) as? String
        cell.imageCellShare.image = UIImage(named: arrayOfImages.objectAtIndex(indexPath.row) as! String)
        return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Table is Selected")
        
        
        
        if(indexPath.row == 0){
            if (btnSharedOffer.tag != 100 ){
                inviteFacebookFriend()
                print("Invite called")
            }else{
                self.showDialgfacebook()
                   print("Share Called")
            }
            
           
            self.viewAlertShare.hidden = true
        
        }else if indexPath.row == 1{
            
            if btnSharedOffer.tag != 100{
              msg = "Hi found this amazing offer. \(_offer.offer_title!) from \(_offer.business_name!) Download the Perkup and get this awasome offer. \(_offer.about!) "
                print("message for Invite:\(msg)")

            }else{
                
                msg = " Subject:\(_offer.sharing_subject!)\n Message: \(_offer.sharing_message!) Click \(_offer.sharing_url!) "
                print("message for Share:\(msg)")


            }
            
            let urlWhats = "whatsapp://send?text=\(msg)"
            if let urlString = urlWhats.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
                if let whatsappURL = NSURL(string: urlString) {
                    if UIApplication.sharedApplication().canOpenURL(whatsappURL) {
                        UIApplication.sharedApplication().openURL(whatsappURL)
                        
                        self.viewAlertShare.hidden = true
                    } else {
                        Alert.showAlert("What'sapp", message: "What'sapp is not installed")
                    }
                }
            }
            self.viewAlertShare.hidden = true

        
        }else if indexPath.row == 2{
         print("Mail")
            inviteByEmail()
        
            self.viewAlertShare.hidden = true
    
        }else if indexPath.row == 3{
         print("SMS")
            
            if btnSharedOffer.tag != 100{
                msg = "Hi found this amazing offer. \(_offer.offer_title!) from \(_offer.business_name!) Download the Perkup and get this awasome offer. \(_offer.about!) "
                print("message for Invite:\(msg)")
                
            }else{
                
                msg = " Subject:\(_offer.sharing_subject!)\n Message: \(_offer.sharing_message!) Click \(_offer.sharing_url!) "
                print("message for Share:\(msg)")
                
            }
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = "\(msg)"
                controller.recipients = ["03423596188"]
                controller.messageComposeDelegate = self
                self.presentViewController(controller, animated: true, completion: nil)
            }
             self.viewAlertShare.hidden = true
            
            
        }
        self.viewAlertShare.hidden = true
        
        
    }
    
    
    // start footer
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.perkupGreen()
        let label = UILabel(frame: CGRectMake(SizeUtil.convertIphone6ToIphone5(50), SizeUtil.convertIphone6ToIphone5(10),SizeUtil.convertIphone6ToIphone5(200), SizeUtil.convertIphone6ToIphone5(21)))
        //label.center = CGPointMake(v.center.x,label.center.y);
        label.textAlignment = NSTextAlignment.Center
        label.text = "Share With Friends"
        label.textColor = UIColor.whiteColor()
        v.addSubview(label)
        
        return v
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SizeUtil.convertIphone6ToIphone5(44)
    }
    
    
    
    // end
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
    }
    
  
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    //sending email delegates and data source
    
    
//    func configuredMailComposeViewController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self
//        
//        if btnSharedOffer.tag != 100{
//            msg = "Hi found this amazing offer. \(_offer.offer_title!) from \(_offer.business_name!) Download the Perkup and get this awasome offer. \(_offer.about!) "
//            print("message for Invite:\(msg)")
//            mailComposerVC.setSubject("Invitation")
//
//            
//        }else{
//            
//            print("offer subject:\(_offer.sharing_subject!)")
//            msg = " Subject:\(_offer.sharing_subject!)\n Message: \(_offer.sharing_message!) Click \(_offer.sharing_url!) "
//            print("message for Share:\(msg)")
//            mailComposerVC.setSubject("\(_offer.sharing_subject!)")
//
//            
//        }
//
//        
//        
//        mailComposerVC.setToRecipients(["ayaz@nextgeni.com"])
//       
//        mailComposerVC.setMessageBody("\(msg)", isHTML: false)
//        return mailComposerVC
//    }
//    // if account is not activated
//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
//    }
//    
//    // MARK: MFMailComposeViewControllerDelegate
//    
//    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
//        controller.dismissViewControllerAnimated(true, completion: nil)
//        
//    }
    
    
    func showDialgfacebook(){
        
//        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
//            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//            
//            facebookSheet.setInitialText(" hi This is Greate Offer")
//            facebookSheet.addURL(NSURL(string: "\(_offer.sharing_url)"))
//            self.presentViewController(facebookSheet, animated: true, completion: nil)
//        } else {
//          //
//                Alert.showAlert("Account", message: "Please login to a Facebook account to share")
//            }
   
        
        
//        let token = FBSDKAccessToken.currentAccessToken()
//        let connection = FBSDKGraphRequestConnection()
//        let requestParam = ["subject":"Hello", "Detail":"This is Perkup","Url":"WWw.google.com"]
//        
        
       // print("Token Of the user",token)
        
        
        let urlPath: String = "fbauth2://"
        let url: NSURL = NSURL(string: urlPath)!
        let isInstalled = UIApplication.sharedApplication().canOpenURL(url)
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://www.google.com")
        content.contentTitle = "My app"
        content.contentDescription = "Description"
        
        
        let dialog = FBSDKShareDialog()
        
        if isInstalled{
            print("Native")
            dialog.mode = FBSDKShareDialogMode.Native;
        }
        else {
            print("Browser")
            dialog.mode = FBSDKShareDialogMode.Browser; //or FBSDKShareDialogModeAutomatic
        }
        
        dialog.shareContent = content;
        dialog.delegate = self;
        dialog.fromViewController = self;
        dialog.show()
        


    
    
    }
    
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        print(results)
        print("did complete ")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer NSError")
        print(error.description)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
 
    



func inviteByEmail(){
    
    let  toEmail = "ayaz@nextgeni.com"
    var  subject = "Sending invitation"
    var  body = "hi "
    
    if btnSharedOffer.tag != 100{
                    msg = "Hi found this amazing offer. \(_offer.offer_title!) from \(_offer.business_name!) Download the Perkup and get this awasome offer. \(_offer.about!) "
                    print("message for Invite:\(msg)")
                   subject = "Invitation"
                   body = "\(msg)"
                }else{
        
                    print("offer subject:\(_offer.sharing_subject!)")
                    msg = " Subject:\(_offer.sharing_subject!)\n Message: \(_offer.sharing_message!) Click \(_offer.sharing_url!) "
                    print("message for Share:\(msg)")
                   subject = "Sharing"
                   body = "\(msg)"
        
                }
        

    
    
    
    if let
        urlString = ("mailto:\(toEmail)?subject=\(subject)&body=\(body)").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding),
        url = NSURL(string:urlString)
    {
        UIApplication.sharedApplication().openURL(url)
    }
}


func inviteFacebookFriend(){
    
   //
//    
//    
//    let dialog : FBSDKShareDialog = FBSDKShareDialog()
//    dialog.mode = FBSDKShareDialogMode.Native
//    // if you don't set this before canShow call, canShow would always return YES
//    if !dialog.canShow() {
//        // fallback presentation when there is no FB app
//        dialog.mode = FBSDKShareDialogModeNative
//    }
//    dialog.show()
//}

//    
//       let  requestContent = FBSDKGameRequestContent()
//            requestContent.message = "\(_offer.sharing_url)"
//            requestContent.title = "My Custom Message"
//            requestContent.recipients = ["www.facebook.com/ayazakbar"]
//            requestContent.actionType = FBSDKGameRequestActionType.AskFor
//    
//    FBSDKGameRequestDialog.showWithContent(requestContent, delegate:self)
//
    
    
  //  this working fine
//    let content = FBSDKAppInviteContent()
//    content.appLinkURL = NSURL(string: "https://fb.me/799704986825012")
//    // need invitation page of url....
//    content.appInvitePreviewImageURL = NSURL(string:"\(_offer.sharing_url)")
//    FBSDKAppInviteDialog.showFromViewController(self, withContent: content, delegate: self);


    }
func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
    print("Complete invite without error")
}

func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
    print("Error in invite \(error)")
    }
    
    @IBAction func showImages(sender: UIButton)
    {
    
    print("didTap Called")
    btnSharedOffer.tag = 100
    
    viewForCollection.frame = CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.height)
    
    viewForCollection.backgroundColor = UIColor.alertBGColor()
    self.view.addSubview(viewForCollection)
    self.viewForCollection.hidden = false
    
}

    @IBAction func closeImagesView(sender:UIButton){
    self.viewForCollection.hidden = true
    }


    @IBAction func closeYesNoAlert(sender: AnyObject) {
        
        viewAlertYESNO.removeFromSuperview();
        
    }
    
    @IBAction func didTapYes(sender: AnyObject) {
        viewAlertYESNO.removeFromSuperview();
        print("Yes is Clicked ")
        self.bookOffer();

    }



    @IBAction func didTapNo(sender: UIButton){
    
         print("no clicked")
        viewAlertYESNO.removeFromSuperview();
    
    }
}
