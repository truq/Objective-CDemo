//
//  ViewController.swift
//  DemoUrdu
//
//  Created by NGI-Noman on 22/08/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

class ViewController: BaseController {

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    addTapGestureDetector()
    
    addKeyboardObserver()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func addTapGestureDetector(){
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func DismissKeyboard(){
    //Calls this function when the tap is recognized.
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }


}

