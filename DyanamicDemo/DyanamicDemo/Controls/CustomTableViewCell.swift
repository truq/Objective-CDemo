//
//  CustomTableViewCell.swift
//  DyanamicDemo
//
//  Created by NGI-Noman on 15/08/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

import Foundation
import UIKit


class CustomTableViewCell: UITableViewCell{
  
  let paymentSelectionView = UIView()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    showPaymentOptionPopUp();
  }
  
  required init?(coder aDecoder: NSCoder) {
    //fatalError("init(coder:) has not been implemented")
    super.init(coder: aDecoder)
  }
  
//  override func awakeFromNib() {
//    super.awakeFromNib()
//    
//    showPaymentOptionPopUp()
//  }
//  
//  func setSelected(selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//  }
//  
  
//  - (void)setUpCell:(DynamicTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//  cell.label.text = [self.dataSource objectAtIndex:indexPath.row];
//  }
  

  func setUpCell(cell:CustomTableViewCell ,indexPath:NSIndexPath){
  
  }
  
  func showPaymentOptionPopUp() {
    
    
    paymentSelectionView.frame = CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(self.frame.width), SizeUtil.convertIphone6ToIphone5(self.frame.height))
    paymentSelectionView.backgroundColor = UIColor.whiteColor()
    paymentSelectionView.layer.borderWidth = 1
    paymentSelectionView.layer.borderColor = UIColor.grayColor().CGColor
    
    let viewWidth = self.frame.size.width
    let viewHeight = self.frame.size.height
    
    
    var positionX , positionY : CGFloat
    
    positionX = viewWidth*0.3
    positionY = SizeUtil.convertIphone6ToIphone5(22)
    
    for item:Int in 0 ..< 9 {
      
      let button = UIButton(frame: CGRectMake(0, 0, SizeUtil.convertIphone6ToIphone5(100), SizeUtil.convertIphone6ToIphone5(45)))
      button.layer.borderColor = UIColor.grayColor().CGColor
      button.layer.borderWidth = 1
      button.center.x = positionX
      button.center.y = positionY
      button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
      button.addTarget(self, action: #selector(CustomTableViewCell.setDonationAmountFromView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
      button.backgroundColor = UIColor.whiteColor()
      button.titleLabel!.font = UIFont(name: "Arial", size: SizeUtil.convertIphone6ToIphone5(17))
      button.tag = item
      paymentSelectionView.addSubview(button)
      
      positionY += button.frame.size.height*1.1
      
      self.frame = CGRectMake(0, 0, self.frame.width, self.frame.height+button.frame.size.height*1.1)
      
      switch (item){
      case 0 :
        button.setTitle("$10", forState: UIControlState.Normal)
        break
      case 1 :
        button.setTitle("$20", forState: UIControlState.Normal)
        break
      case 2 :
        button.setTitle("$40", forState: UIControlState.Normal)
        break
      case 3 :
        positionX = button.center.x + button.frame.size.width*1.2
        positionY = SizeUtil.convertIphone6ToIphone5(60)
        button.setTitle("$50", forState: UIControlState.Normal)
        break
      case 4 :
        button.setTitle("$100", forState: UIControlState.Normal)
        break
      case 5 :
        button.setTitle("$200", forState: UIControlState.Normal)
        break
      case 6 :
        button.setTitle("$250", forState: UIControlState.Normal)
        break
      case 7 :
        button.setTitle("$500", forState: UIControlState.Normal)
        break
      case 8 :
        button.frame = CGRectMake(viewWidth*0.135, positionY-SizeUtil.convertIphone6ToIphone5(70), SizeUtil.convertIphone6ToIphone5(220), SizeUtil.convertIphone6ToIphone5(45))
        button.backgroundColor = UIColor.brownColor()
        button.setTitle("Other Amount", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        break
      default :
        break
      }
      
    }
    
    self.contentView.addSubview(paymentSelectionView);
    
  }
  
  func setDonationAmountFromView(sender : AnyObject){
    
    // Update Label Of Donatiion Amount
    
    let button = sender as! UIButton
    
    print(button.tag)
    
    if !button.selected.boolValue{
      button.backgroundColor = UIColor.greenColor()
      button.titleLabel?.textColor = UIColor.whiteColor()
      button.tintColor = UIColor.greenColor()
      button.selected = true
      if button.tag == 8{
        button.backgroundColor = UIColor.brownColor()
        button.tintColor = UIColor.brownColor()
  
      }
    }
    else {
      button.backgroundColor = UIColor.whiteColor()
      button.titleLabel?.textColor = UIColor.grayColor()
      button.tintColor = UIColor.grayColor()
      button.selected = false
    }
  
  }
  
}