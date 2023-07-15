//
//  AIGlobals.swift
//  Swift3CodeStructure
//
//  Created by Abhay Pansora on 25/11/2016.
//  Copyright © 2016 Abhay Pansora. All rights reserved.
//

import Foundation
import UIKit


//MARK: - GENERAL
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: - MANAGERS

let ServiceManager = AIServiceManager.sharedManager
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let ipad_storyboard = UIStoryboard(name: "StoryboardiPad", bundle: nil)


//MARK: - APP SPECIFIC
let APP_NAME = "Propelius Test"



func getStringFromDictionary(_ dict:AnyObject) -> String{
    var strJson = ""
    do {
        let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        strJson = String(data: data, encoding: String.Encoding.utf8)!
    } catch let error as NSError {
        print("json error: \(error.localizedDescription)")
    }
    return strJson
}
let IMG_ERROR = "ic_warning"

let USERDEFAULT_NAME = "AppleIDName"
let USERDEFAULT_EMAIL = "AppleIDEmail"
let USERDEFAULT_FNAME = "AppleFName"
let USERDEFAULT_LNAME = "AppleLName"
let USERDEFAULT_ID = "AppleUserID"
let NOTIFICATION = "NOTIFICATION"

//SOCAAL LOGIN
let SOCIAL_ID                           = "id"
let SOCIAL_EMAIL                        = "email"
let SOCIAL_USERNAME                     = "userName"
let SOCIAL_NAME                         = "SOCIAL_NAME"
let SOCIAL_PROFILE_URL                  = "ProfileUrl"
let SOCIAL_PHOTO_URL                    = "PhotoUrl"
let SOCIAL_FIRST_NAME                   = "fn"
let SOCIAL_LAST_NAME                    = "ln"

let SOCIAL_GENDER                       = "Gender"
let SOCIAL_ADDRESS                      = "Address"

//MARK: - IMAGE
func ImageNamed(_ name:String) -> UIImage?{
    return UIImage(named: name)
}
let FONT_REGULAR = "Montserrat-Regular"
let FONT_EXTRALIGHT = "Montserrat-ExtraLight"
let FONT_THIN = "Montserrat-Thin"
let FONT_LIGHT = "Montserrat-Light"
let FONT_MEDIUM = "Montserrat-Medium"
let FONT_SEMIBOLD = "Montserrat-SemiBold"
let FONT_BOLD = "Montserrat-Bold"
let FONT_EXTRABOLD = "Montserrat-ExtraBold"
let FONT_BLACK = "Montserrat-Black"

let FONT_NEXA_BOOK = "Nexa-Book"
let FONT_NEXA_THIN = "Nexa-Thin"
let FONT_NEXA_HEAVY = "Nexa-Heavy"
let FONT_NEXA_BOLD = "Nexa Bold"
let FONT_NEXA_LIGHT = "Nexa Light"

//MARK: - PICKERVIEW TOOLBAR
let toolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 40 / 100))

//NEW MODIFICATION
let APP_THEAM_COLOR = RGBCOLOR(12, g: 14, b:23)
let APP_BACKGROUND_COLOR = RGBCOLOR(244, g: 244, b:244)//F4F4F4
//let APP_BACKGROUND_COLOR = RGBCOLOR(14, g: 15, b:19)
let APP_BLUE_COLOR = RGBCOLOR(15, g: 104, b:203)
let APP_COMPLETE_BACKGROUND_COLOR = RGBCOLOR(24, g: 27, b:35)
let APP_GRAY_COLOR = RGBCOLOR(119, g: 119, b:119)
let APP_WHITE_COLOR = RGBCOLOR(238, g: 238, b:248)
let APP_LIGHT_WHITE_COLOR = UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 248.0/255.0,alpha: 0.7)
let APP_TEXTFIELD_BG_COLOR = RGBCOLOR(29, g: 34, b: 44)
let APP_CLEAR_COLOR = UIColor.clear
let APP_RED_COLOR = RGBCOLOR(195, g: 46, b: 82)
let APP_GREEN_COLOR = RGBCOLOR(77, g: 153, b: 50)
let APP_CENTER_COLOR = RGBCOLOR(72, g: 26, b: 131)
let APP_END_COLOR = RGBCOLOR(92, g: 31, b: 223)
let APP_START_COLOR = RGBCOLOR(6, g: 55, b: 111)

let APP_BOARDER_CENTER_COLOR = RGBCOLOR(255, g: 255, b: 255)
let APP_BOARDER_END_COLOR = RGBCOLOR(206, g: 214, b: 224)
let APP_BOARDER_START_COLOR = RGBCOLOR(152, g: 152, b: 152)
//let APP_GREEN_COLOR = RGBCOLOR(74, g: 173, b: 39)

let APP_CORNER_RADIOUS_5:CGFloat = 5
let APP_CORNER_RADIOUS_10:CGFloat = 10
let APP_CORNER_RADIOUS_30:CGFloat = 30


//MARK: - KEYS
let KEY_IS_FIRSTTIME_OPEN = "KEY_IS_FIRSTTIME_OPEN"
let KEY_IS_USER_LOGGED_IN = "KEY_IS_USER_LOGGED_IN"
let KEY_IS_GUEST_USER_LOGGED_IN = "KEY_IS_GUEST_USER_LOGGED_IN"
let GUEST_USER = "GUEST_USER"
let KEY_LOGGED_IN_USER_TOKEN = "KEY_LOGGED_IN_USER_TOKEN"
let KEY_IS_SHOW_INTRO =  "KEY_IS_SHOW_INTRO"
let AIUSER_CURRENTUSER_STORE = "AIUSER_CURRENTUSER_STORE"
let AIGUESTUSER_CURRENTUSER_STORE = "AIGUESTUSER_CURRENTUSER_STORE"
let USER = "user"
let USER_TOKEN = "user_token"
let KEY_IS_SHOW_INTRO_ANNIMATION =  "KEY_IS_SHOW_INTRO_ANNIMATION"
let KEY_BACKGOUND_DATE = "KEY_BACKGOUND_DATE"
let KEY_CRASH_COLLECTION = "is_collect_crash_data"
let KEY_IS_START_FROM_PAGE = "KEY_IS_START_FROM_PAGE"

//MARK: - SCREEN SIZE
let NAVIGATION_BAR_HEIGHT:CGFloat = 64
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//MARK: - Date Formate
let DATE_FORMATE = "dd/MM/yyyy"
let DATE_FORMATE_BE = "yyyy-MM-dd"

//MARK: - Other Data

let APP_TEXTFIELD_CORNER_REDIUS = 8.0

// MARK: - KEYS FOR USERDEFAULTS
let DeviceToken = "DeviceToken"
let FIREBASE_TOKEN = "firebase_token"
let userDefualt = UserDefaults.standard



let key256   = "26mwMPdeVrcsVDtGNT5LNrM56PcCJ5qL" //"abcdefghigklnmopqrst123456789762"   // 32 bytes for AES256
let iv       = "26mwMPdeVrcsVDtG"

func printToConsole(message : String) {
    #if DEBUG
    print(message)
    #endif
}
