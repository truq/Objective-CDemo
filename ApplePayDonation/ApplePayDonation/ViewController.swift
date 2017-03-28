//
//  ViewController.swift
//  ApplePayDonation
//
//  Created by NGI-Noman on 18/01/2017.
//  Copyright © 2017 NGI-Noman. All rights reserved.
//

import UIKit
import PassKit
import Stripe

class ViewController: UIViewController,PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtDonationAmount: UITextField!
    @IBOutlet weak var btnDonate: UIButton!
    @IBOutlet weak var lblThankyouMessage: UILabel!
    
    var _btnApplePay : UIButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]) {
            _btnApplePay = self.applePayButton()
            //Set location of Apple Pay button
            _btnApplePay.frame = CGRect(x:0, y: CGFloat(txtDonationAmount.frame.origin.y + txtDonationAmount.frame.size.height + 22.0), width: CGFloat(_btnApplePay.frame.size.width), height: CGFloat(_btnApplePay.frame.size.height))
            _btnApplePay.center.x = self.view.center.x
            _btnApplePay.setTitle("Donate With", for: UIControlState.normal)
            self.view.addSubview(_btnApplePay)
        }
        else {
            //Create alternate payment flow
        }

    }
    
    func applePayButton() -> UIButton {
        
        let button = PKPaymentButton(type: .plain, style: .black)
        
        button.addTarget(self, action: #selector(self.tappedApplePay), for: .touchUpInside)
        return button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //www.facebook.com/truqchal

    func tappedApplePay() {
        if self.checkFormValid() {
            let paymentRequest: PKPaymentRequest? = self.paymentRequest(txtDonationAmount.text!)
            let vc = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest!)
            vc.delegate = self
            self.present(vc, animated: true, completion: { _ in })
        }
        else {
            let alert = UIAlertController(title: "Please fill in all details", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                alert.dismiss(animated: true, completion: { _ in })
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: { _ in })
        }
    }
    
    func checkFormValid() -> Bool {
        var valid: Bool = false
        if (txtUserName.text == "") || (txtUserEmail.text == "") || (txtDonationAmount.text == "") {
            valid = false
        }
        else {
            valid = true
        }
        return valid
    }

    func paymentRequest(_ amount: String) -> PKPaymentRequest {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.xxx.xxxx"
        paymentRequest.supportedNetworks = [PKPaymentNetwork.amex, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
        paymentRequest.merchantCapabilities = PKMerchantCapability.capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Donation", amount: NSDecimalNumber(string:amount))]
        
        return paymentRequest
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        self.handlePaymentAuthorization(with: payment, completion: completion)
    }
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        txtDonationAmount.text = "";
        txtUserEmail.text = "";
        txtUserName.text = "";
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func handlePaymentAuthorization(with payment: PKPayment, completion: @escaping (_: PKPaymentAuthorizationStatus) -> Void) {

        STPAPIClient.shared().createToken(with: payment) { (token:STPToken?,error: Error?) in
            
            if ((error) != nil){
                completion(.failure);
                return
            }
            self.createBackendCharge(with: token!, completion: completion);
            
        }

    }
    
    func createBackendCharge(with token: STPToken, completion: @escaping (_: PKPaymentAuthorizationStatus) -> Void) {
        //We are printing Stripe token here, you can charge the Credit Card using this token from your backend.
        print("Stripe Token is \(token)")
        completion(.success)
        //Displaying user Thank you message for payment.
        self.lblThankyouMessage.isHidden = false
        self._btnApplePay.isHidden = true
        self.btnDonate.isHidden = false
    }
    
    @IBAction func didTapOnDonateAgain(_ sender: Any) {
        
        _btnApplePay.isHidden = false;
        btnDonate.isHidden = true;
        lblThankyouMessage.isHidden = true;
    }
}

