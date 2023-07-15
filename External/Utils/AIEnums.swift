//
//  AIEnums.swift
//  Swift3CodeStructure
//
//  Created by Abhay Pansora on 25/11/2016.
//  Copyright © 2016 Abhay Pansora. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//MARK:- AIEdge
enum AIEdge:Int {
    case
    top,
    left,
    bottom,
    right,
    top_Left,
    top_Right,
    bottom_Left,
    bottom_Right,
    all,
    none
}

enum OTP_TYPE: Int {
    case UPDATE_PROFILE
    case REGISTER
    case MANUAL_SIGNUP
}
enum PARTICIPANT_FROM : String{
    case PARTICIPANT
    case ACCEPTED
    case PENDING
    case FREEE_SLOT
}

enum SOCIAL_LOGIN: Int {
    case DUMMY
    case GOOGLE
    case FACEBOOK
}
enum LOGIN_TYPE: Int {
    case WITH_LOGIN
    case WITHOUT_LOGIN
}
enum WEB_PAGE: String {
    case PRIVACY_POLICY
    case TERMS_USE
    case FOSS
    case ABOUTUS
    case FAQ
    case CHALLENGE_DETAILS
    case IMPRINT
    case INTERPLACECLUBCODE
    case GTC
}

enum FROM_PAGE: String{
    case GET_IN_TOUCH
    case LEGAL
    case SIGNUP
    case SIGNIN
    case VERIFYOTP
    case SETTING
    case FORGOT_PASSWORD
    case LINK_EXPIRE
    case ADD_INFO
    case PRMO_CODE
    case BODY_PAIN
    case BODY_WORKOUT
    case GENERAL_SETTINGS
    case WORKOUT_SETTINGS
    case VOICE_GUIDE
    case TIMER_SETTING
    case DELETE_ACCOUNT
    case FIVE_MIN_WORKOUT
    case ON_GOING_WORKOUT
    case WORKOUTS
    case CHALLENGE
    case FULLBODYWORKOUT
    case RECOMMENDEDWORKOUT
    case EXCLUSIVEWORKOUT
}

public enum VersionError: Error {
  case invalidResponse, invalidBundleInfo
}
