//
//  WebViewController.swift
//  DemoUrdu
//
//  Created by NGI-Noman on 22/08/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let url = NSURL (string: "http://www.bbc.com/urdu/sport")
      let requestObj = NSURLRequest(URL: url!);
      webView.loadRequest(requestObj)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func didTapOnScience(sender: AnyObject) {
    
    let url = NSURL (string: "http://www.bbc.com/urdu/sport")
    let requestObj = NSURLRequest(URL: url!);
    webView.loadRequest(requestObj)
  }

  @IBAction func didTapOnSports(sender: AnyObject) {
    
    let url = NSURL (string: "http://www.bbc.com/urdu/science/index.xml")
    let requestObj = NSURLRequest(URL: url!);
    webView.loadRequest(requestObj)
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
