//
//  DesignModel.swift
//  OctaApp
//
//  Created by Sansus soft on 31/05/17.
//  Copyright © 2017 Sansus soft. All rights reserved.
//

import UIKit
import AVFoundation

//**************************COLOR******************************************
class DesignModel: NSObject {

    class func setLeftButton(_ textField: UITextField, image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: CGFloat(10), y: CGFloat(0), width: CGFloat(30), height: CGFloat(30)))
        let view = UIView(frame: CGRect(x: 10, y: 0, width: 45, height: 30))
        view.contentMode = .center
        imageView.image = image
        imageView.contentMode = .center
        textField.leftViewMode = .always
        view.addSubview(imageView)
        textField.leftView = view
    }
    
    class func setRightButton(_ textField: UITextField, image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: CGFloat(-10), y: CGFloat(0), width: CGFloat(15), height: CGFloat(9)))
        let view = UIView(frame: CGRect(x: -10, y: 0, width: 15, height: 9))
        view.contentMode = .center
        imageView.image = image
        imageView.contentMode = .center
        textField.rightViewMode = .always
        view.addSubview(imageView)
        textField.rightView = view
    }
    
    class func removePlus (countryCode: String?) -> String {
        let strcountrycode: String = countryCode!.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range: nil)
        return strcountrycode
    }
    
    //MARK: -DATE FORMATTING METHODS
    
    class func getCurrentDate(_ dateFormate: String) -> String {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormate
        let currentDate: String = dateFormatter.string(from: currDate)
        return currentDate
    }
    
    class func stringToDate(_ str: String, strformate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = strformate
        if formatter.date(from: str) != nil {
            return formatter.date(from: str)!
        } else {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter.date(from: str)!
        }    
    }
    
    class func dateToString(_ str: Date, strformate: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = strformate
        return formatter.string(from: str)
    }
    
    class func combineDateWithTime(date: NSDate, time: NSDate) -> NSDate? {
        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.year,.month,.day], from: date as Date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time as Date)
        let mergedComponments = NSDateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        mergedComponments.hour = timeComponents.hour!
        mergedComponments.minute = timeComponents.minute!
        mergedComponments.second = timeComponents.second!
        return calendar.date(from: mergedComponments as DateComponents) as NSDate?
    }

    class func convertDateToString(date: Date, inFormate: String, outFormate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = inFormate //"yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = outFormate //"dd-MM-yyyy HH:mm:ss"
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }

    class func getCurrentStringFromUTCString(strDate : String!, oldFormat : String!, newFormat : String!) -> String!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat!
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: strDate) ?? Date()
        dateFormatter.dateFormat = newFormat!
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    class func convertDateToAnotherFormate(_ str: String, strInformate: String, strOutFormate: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strInformate
        dateFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date1 = dateFormat.date(from: str)
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = strOutFormate
        return dateFormat1.string(from: date1!)
    }
    
    class func convertUTCDateToLocal(_ str: String, strformate: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strformate
        dateFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date1 = dateFormat.date(from: str)
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = strformate
        dateFormat1.timeZone = NSTimeZone.local
        return dateFormat1.string(from: date1!)
    }
    
    class func convertLocaltoUTC(_ str: String, strformate: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strformate
        dateFormat.timeZone = NSTimeZone.local
        let date1 = dateFormat.date(from: str)
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = strformate
        dateFormat1.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormat1.string(from: date1!)
    }
    
    class func convertUTCDateToAnotherFormate(_ str: String, strInformate: String, strOutFormate: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strInformate
        dateFormat.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date1 = dateFormat.date(from: str)
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = strOutFormate
        dateFormat1.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormat1.string(from: date1!)
    }
    
    class func convertOriginalDateToAnotherFormate(_ str: String, strInformate: String, strOutFormate: String) -> String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strInformate
        let date1 = dateFormat.date(from: str)
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = strOutFormate
        return dateFormat1.string(from: date1!)
    }
    
    class func getDayDifference(date: Date) -> Int {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: Date())
        return difference.day ?? 0
    }
    
    class func getHourDifference(date: Date) -> Int {
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: Date())
        return difference.hour ?? 0
    }

    class func getSecondDifference(date: Date, enddate: Date) -> Int {
        //get both times sinces refrenced date and divide by 60 to get minutes
        let newDateSecond = enddate.timeIntervalSinceReferenceDate
        let oldDateSecond = date.timeIntervalSinceReferenceDate
        return Int(newDateSecond - oldDateSecond)
    }
    
    class func getMinuteDifference(startdate: Date, endDate: Date) -> Int {
        //get both times sinces refrenced date and divide by 60 to get minutes
        let newDateMinute = endDate.timeIntervalSinceReferenceDate/60
        let oldDateMinute = startdate.timeIntervalSinceReferenceDate/60
        return Int(newDateMinute - oldDateMinute)
    }
    
    class func getStringToUTCDate(strDate: String, formate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from:strDate)!
        return date
    }
    
    class func getStringToDate(strDate: String, formate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from:strDate)!
        return date
    }
}
