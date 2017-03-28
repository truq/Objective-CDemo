//
//  NotificationViewContlroller.swift
//  PerkUp
//
//  Created by NGI-Raheel Mateen on 01/03/2016.
//  Copyright © 2016 NGI-Raheel Mateen. All rights reserved.
//

import Foundation
import UIKit
class NotificationViewContlroller: BaseController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftButton();
        setNavigationTitleText("Notifications");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : TableViewDelegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath) as! NotificationTableViewCell
                cell.selectionStyle = .None
        return cell
    }
    
}