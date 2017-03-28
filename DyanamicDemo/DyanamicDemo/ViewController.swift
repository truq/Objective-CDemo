//
//  ViewController.swift
//  DyanamicDemo
//
//  Created by NGI-Noman on 11/08/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
//      tableView.estimatedRowHeight = 300
//      tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return  5
  }
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let cellIdentifier:String = "CustomFields\(indexPath.row)"
    var cell:CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CustomTableViewCell
    if (cell == nil)
    {
//      var nib:Array = NSBundle.mainBundle().loadNibNamed("CustomTableViewCell", owner: self, options: nil)
//      cell = nib[0] as? CustomTableViewCell
      cell = CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    
//    let rowHeigth : CGFloat = (cell?.frame.height)!
    
//    switch indexPath.row {
//    case 0:
//      rowHeigth = 500;
//      break
//    case 1:
//      rowHeigth = 500;
//      break
//    case 2:
//      rowHeigth = 500;
//      break
//    case 3:
//      rowHeigth = 500;
//      break
//    case 4:
//      rowHeigth = 500;
//      break
//    default:
//      rowHeigth = 500;
//      break
//      
//    }
    
    return self.heightForBasicCellAtIndexPath(indexPath)/2
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cellIdentifier:String = "CustomFields\(indexPath.row)"
    var cell:CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CustomTableViewCell
    if (cell == nil)
    {
//      var nib:Array = NSBundle.mainBundle().loadNibNamed("CustomTableViewCell", owner: self, options: nil)
//      cell = nib[0] as? CustomTableViewCell
      cell = CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    return cell!
    
    
    
  }
  // method to run when table view cell is tapped
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You tapped cell number \(indexPath.row).")
  }
  
  
  func calculateHeightForConfiguredSizingCell(cell: CustomTableViewCell) -> CGFloat
  {
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    let height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize).height + 1.0
    return height
  }
  
  func heightForBasicCellAtIndexPath(indexPath: NSIndexPath)-> CGFloat {
    let cellIdentifier:String = "CustomFields\(indexPath.row)"
    var cell:CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CustomTableViewCell
    if (cell == nil)
    {
      cell = CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    return self.calculateHeightForConfiguredSizingCell(cell!)
  }
  
  
  
}

