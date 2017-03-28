//
//  StringUtil.swift
//  FeelingBless
//
//  Created by NGI-NOMAN on 10/7/15.
//  Copyright (c) 2015 NGI-NOMAN. All rights reserved.
//

import Foundation

class StringUtil : NSObject {
    
    
    static func isEmptyOrNull(value : String) -> Bool{
        
        // check string is null or empty
        
        if value.isEmpty || value == "" || value == "<null>"{
            return true}
        else {return false}
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        
        // email validation
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(emailStr)
    }
    
    static func mergeTwoStringBySpace(strOne:String , strTwo:String) -> String{
        
        return strOne+" "+strTwo;
    }
    
    
    static func breakStringBySpace(fullStr:String) -> [String]{
        
        
      let splitStrArray = fullStr.characters.split{$0 == " "}.map(String.init)
      return splitStrArray as [String]
    }
    
    static func getFirstNameFromArray(stringArray:[String]) -> String{
        
        if StringUtil.isEmptyOrNull(stringArray[0]){
            return "";
        }
        
        return stringArray[0];
        
    }
    static func getLastNameFromArray(stringArray:[String]) -> String{
        
        print(stringArray.count);
        if(stringArray.count == 1){

            return ""
        }
        
        return stringArray[1];
        
    }
    
    static func getAmountStrSepratedByComma(amount : Double) -> String{
        

        // parameter double
        // make string Comma Seprated
        // return String
        
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .DecimalStyle
        fmt.stringFromNumber(amount)  // "2,358,000"
        print(NSString(format: "%@", fmt.stringFromNumber(amount)!) as String)
        return NSString(format: "%@", fmt.stringFromNumber(amount)!) as String
        
    }
    
    static func compareTwoDate(date: String , compareableDate: String)-> Bool{
        
        /*
        @param take two String parameter start date and end date
        @Compare Two Dates
        @Return Boolean Value .
        */
        
        var boolValue = false
        
        let datePickerFormat = NSDateFormatter()
        datePickerFormat.dateFormat = "MM/dd/yyyy"
        let startDate = datePickerFormat.dateFromString(date)
        let endDate = datePickerFormat.dateFromString(compareableDate)
        
        var result : NSComparisonResult
        
        result = (startDate?.compare(endDate!))! // comparing two dates
        
        switch result{
            
        case .OrderedAscending:
            print("start date is less")
            boolValue = false
            break
        case .OrderedDescending:
            print("end date is less")
            boolValue = true
            break
        case .OrderedSame:
            print("both are same")
            boolValue = false
            break
            
            
        }
        return boolValue
        
    }
    
    static func getDateFromString(dateString : String) -> String{
        
        let datePickerFormat = NSDateFormatter()
        datePickerFormat.dateFormat = "yyyy/dd/MM"
        let startDate = datePickerFormat.dateFromString(dateString)!
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.stringFromDate(startDate)
        
    }
    
    static func removeNullValuesFromDict(dict:NSDictionary) -> NSMutableDictionary{
        
        let filterDict = NSMutableDictionary()
        for nullValue in dict {
            
                    if nullValue.value.isKindOfClass(NSNull){
                        
                        print(nullValue);
                        
                        filterDict.setObject(" " as String, forKey:nullValue.key as! String)
                        
                        
                    }
                    else{
                        filterDict.setObject(nullValue.value , forKey:nullValue.key as! String)
                    }
        }
    
        
        return filterDict;
    }
    
    
    func convertMileToKilometer(mile:Double) -> Double{
        
        return mile * 1.609344 as Double
    }
    
//    func latitiudeInDegree() ->String{
//        
//    }
    
}