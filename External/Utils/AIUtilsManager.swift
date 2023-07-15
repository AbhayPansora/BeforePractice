
//
//  AIUtilsManager.swift
//  Swift3CodeStructure
//
//  Created by Abhay Pansora on 25/11/2016.
//  Copyright © 2016 Abhay Pansora. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

let CUSTOM_ERROR_DOMAIN = "CUSTOM_ERROR_DOMAIN"
let CUSTOM_ERROR_USER_INFO_KEY = "CUSTOM_ERROR_USER_INFO_KEY"
var player: AVAudioPlayer?

// MARK: - INTERNET CHECK

func IS_INTERNET_AVAILABLE() -> Bool{
    AIReachabilityManager.sharedManager.doSetupReachability()
    if AIReachabilityManager.sharedManager.reachability.connection == .unavailable {
        return false
    } else {
        return true
    }
}

func SHOW_INTERNET_ALERT(){
    HIDE_CUSTOM_LOADER()
    displayAlertWithMessage("No Internet")
}

func removeSpecialCharsFromString(text: String) -> String {
    let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890 ")
    return String(text.filter {okayChars.contains($0) })
}

// MARK: - CUSTOM ALERT

// MARK: - ALERT
func displayAlertWithMessage(_ message:String) -> Void {
    //displayCustomErrorAlert(message, img: IMG_ERROR)
    displayAlertWithTitle(APP_NAME, andMessage: message, buttons: ["Ok"], completion: nil)
    
}

func displayAlertWithMessageLeft(_ message:String) -> Void {
    displayAlertWithTitleLeft("", andMessage: message, buttons: ["Ok"], completion: nil)
}

func displayAlertWithMessageFromVC(_ vc:UIViewController, message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        alertController.setValue(NSAttributedString(string: APP_NAME, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : APP_WHITE_COLOR]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : APP_WHITE_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    vc.present(alertController, animated: true, completion: nil)
}

func displayAlertWithTitleLeft(_ title:String, andMessage message:String, buttons:[String], completion:(( _ index:Int) -> Void)!) -> Void {
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: FONT_BOLD, size: 17)!,NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.init(name: FONT_BOLD, size: 14)!,NSAttributedString.Key.foregroundColor : APP_WHITE_COLOR, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    UIApplication.shared.windows.first?.rootViewController!.present(alertController, animated: true, completion:nil)
}

func displayAlertWithTitle(_ title:String, andMessage message:String, buttons:[String], completion:(( _ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : APP_THEAM_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true) {
        // optional code for what happens after the alert controller has finished presenting
    }
//    UIApplication.shared.windows.first?.rootViewController!.present(alertController, animated: true, completion:nil)
    /*let window = UIApplication.shared.windows.last!
    var viewPopUp : PopUpView!
    viewPopUp = Bundle.main.loadNibNamed("PopUpView", owner: UIApplication.shared.windows.last?.rootViewController?.view, options: nil)![0] as? PopUpView
    viewPopUp.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    window.addSubview(viewPopUp)*/
    //displayCustomPopup(TSLanguageManager.localizedString("LBL_OOPS")+"!", description: "No Internet Connection Found check your Connection",BackImg:"", img: "img_opps", fristButton: TSLanguageManager.localizedString("BTN_TRY_AGAIN"), secondButton: TSLanguageManager.localizedString("NO"), isImgHidden: false, isSecondBtnHidden: true,isBackImgHidden: true)

}
//MARK: Set Custom popup

func onClickPopupCancel(_ sender: Any) {
    for subView in (UIApplication.shared.windows.first?.rootViewController?.view)!.subviews{
        if subView.tag == 1001{
            subView.removeFromSuperview()
       }
    }
}
func displayAlertWithTitle(_ vc:UIViewController, title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: FONT_BOLD, size: 17)!,NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")

        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: FONT_BOLD, size: 17)!,NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    vc.present(alertController, animated: true, completion: nil)
}

func isValidEmail(_ stringToCheckForEmail:String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
}

func isValidateCourse(_ strToCheckCourseName: String) -> Bool {
    let courseName = "[A-Z0-9a-z]+"
    return NSPredicate(format: "SELF MATCHES %@", courseName).evaluate(with: strToCheckCourseName)
}

func isValidPassword(_ str:String) -> Bool {
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#$%^&*.,?|{}<>():;€/'£%=¥~]).+$"
    let Regex = "(?=^.{6,}$)(?=.*\\d)(?=.*\\W+)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
    
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?![.\n]).+$"

    return NSPredicate(format: "SELF MATCHES %@", Regex).evaluate(with: str)
}
func isContaintNumber(_ str:String) -> Bool {
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#$%^&*.,?|{}<>():;€/'£%=¥~]).+$"
    let Regex = ".*[0-9]+.*"
    
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?![.\n]).+$"

    return NSPredicate(format: "SELF MATCHES %@", Regex).evaluate(with: str)
}
func isContaintCapitalLatter(_ str:String) -> Bool {
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#$%^&*.,?|{}<>():;€/'£%=¥~]).+$"
    let Regex = ".*[A-Z]+.*"
    
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?![.\n]).+$"

    return NSPredicate(format: "SELF MATCHES %@", Regex).evaluate(with: str)
}
func isContaintLowerCase(_ str:String) -> Bool {
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#$%^&*.,?|{}<>():;€/'£%=¥~]).+$"
    let Regex = ".*[a-z]+.*"
    
//    let Regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?![.\n]).+$"

    return NSPredicate(format: "SELF MATCHES %@", Regex).evaluate(with: str)
}
func isContaint8Chr(_ str:String) -> Bool {
    let passWordRegEx = "^.{8,}$"
     let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
     return passwordTest.evaluate(with: str)
}
func isContaintSpecialChr(_ str:String) -> Bool {
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    if str.rangeOfCharacter(from: characterset.inverted) != nil {
        //print("string contains special characters")
        return true
    }
    return false
}

func IS_IPHONE_PRO_MAX()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 896
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//MARK:- DEVICE CHECK

//Check IsiPhone Device
func IS_IPHONE_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .phone
    return deviceType
}

//Check IsiPad Device
func IS_IPAD_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .pad
    return deviceType
}

func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    //      let hours: Int = totalSeconds / 3600
    return String(format: "%02d:%02d",minutes,seconds)
}


//iPhone 4 OR 4S
func IS_IPHONE_4_OR_4S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 480
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 5 OR OR 5C OR 4S
func IS_IPHONE_5_OR_5S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 568
    var device:Bool = false
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 6 OR 6S
func IS_IPHONE_6_OR_6S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 667
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone 6Plus OR 6SPlus
func IS_IPHONE_6P_OR_6SP()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 736
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//iPhone X
func IS_IPHONE_X()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 812
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST <= SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//iPhone Xr
func IS_IPHONE_XR()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 896
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//iPhone 12 pro max
func IS_IPHONE_12_PRO_MAX()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 926
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//MARK:- DEVICE ORIENTATION CHECK
func IS_DEVICE_PORTRAIT() -> Bool {
    return UIDevice.current.orientation.isPortrait
}

func IS_DEVICE_LANDSCAPE() -> Bool {
    return UIDevice.current.orientation.isLandscape
}
func convertStringToDate(dateStr: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone.current// (abbreviation: "GMT+0:00")
    let dateFromString = dateFormatter.date(from: dateStr)
    return dateFromString!
}
//MARK:- PLAY CUSTOM SOUND
func playSound(soundname: String) {
    guard let url = Bundle.main.url(forResource: soundname, withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else { return }
        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}

func openUrl(url : URL){
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:]) { (isDone) in
            print("done  \(isDone)")
        }
    } else {
        UIApplication.shared.openURL(url)
    }
}

// MARK: - USERDEFAULTS
func setUserDefaultValues(_ key : String , value : String){
    let userDefault = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}
func setDateUserDefaultValue(_ key : String , value : Date){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func setIntUserDefaultValue(_ key : String , value : Int){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func getDateUserDefaultValue(_ key : String) -> Date{
    let userDefault : UserDefaults = UserDefaults.standard
    var value : Date = Date()
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! Date
    }
    return value
}

func getIntUserDefaultValue(_ key : String) -> String{
    let userDefault : UserDefaults = UserDefaults.standard
    var value : Int = 0
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! Int
    }
    return String(value)
}

func getUserDefaultValue(_ key : String) -> String{
    let userDefault = UserDefaults.standard
    var value : String = ""
    if userDefault.value(forKey: key) != nil{
        value = userDefault.value(forKey: key) as! String
    }
    return value
}

func setBoolUserDefaultValue(_ key : String , value : Bool){
    let userDefault : UserDefaults = UserDefaults.standard
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
}

func getBoolUserDefaultValue(_ key : String) -> Bool{
    var value : Bool = false
    let userDefault : UserDefaults = UserDefaults.standard
    if userDefault.value(forKey: key) != nil{
        value = ((userDefault.value(forKey: key) as? Any) != nil)
    }
    return value
}

func setAttributedLabel(strString : String, lbl:UILabel)  {
    var myMutableString = NSMutableAttributedString()
    myMutableString = NSMutableAttributedString(string: strString)
    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: APP_WHITE_COLOR, range: NSRange(location:strString.count - 1 ,length:1))
    lbl.attributedText = myMutableString
}

//MARK: - COLORS
public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

public func RGBCOLOR(_ r: CGFloat, g: CGFloat , b: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

func GET_PROPORTIONAL_WIDTH (_ width:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * width)/375)
}
func GET_PROPORTIONAL_HEIGHT (_ height:CGFloat) -> CGFloat {
    return ((SCREEN_HEIGHT * height)/667)
}

func GET_PROPORTIONAL_WIDTH_CELL (_ width:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * width)/375)
}
func GET_PROPORTIONAL_HEIGHT_CELL (_ height:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * height)/667)
}


