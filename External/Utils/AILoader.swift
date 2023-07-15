//
//  AILoader.swift
//
//  Created by Abhay Pansora on 24/06/23.
//  Copyright © 2023 Abhay Pansora. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


private var activityRestorationIdentifier: String {
    return "NVActivityIndicatorViewContainer"
}

public func ShowLoaderWithMessage(message:String) {
    startActivityAnimating(size: CGSize(width:56, height:56), message: message, type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 2,isFromOnView: false)
}

//MARK:- ShowLoader

public func SHOW_CUSTOM_LOADER() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 2,isFromOnView: false)
}

//MARK:- Hide Loader

public func HIDE_CUSTOM_LOADER() {
    stopActivityAnimating(isFromOnView: false)
}

//MARK:- ShowLoaderOnView

public func ShowLoaderOnView() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: 2,isFromOnView: true)
}

//MARK:- HideLoaderOnView

public func HideLoaderOnView() {
    stopActivityAnimating(isFromOnView: true)
}

private func startActivityAnimating(size: CGSize? = nil, message: String? = nil, type: NVActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil, isFromOnView:Bool) {
    let activityContainer: UIView = UIView(frame: CGRect(x:0, y:0,width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
    activityContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    activityContainer.restorationIdentifier = activityRestorationIdentifier
    
    activityContainer.isUserInteractionEnabled = false
    let actualSize = size ?? CGSize(width:56,height:56)
    
    let activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x:0, y:0, width:actualSize.width, height:actualSize.height),
        type: type!,
        color: color!,
        padding: padding!)
    
    activityIndicatorView.center = activityContainer.center
    activityIndicatorView.startAnimating()
    activityContainer.addSubview(activityIndicatorView)
    
     if message != nil {
           let width = activityContainer.frame.size.width / 2
           if let message = message , !message.isEmpty {
               let label = UILabel(frame: CGRect(x:0, y:0,width:width, height:30))
               label.center = CGPoint(
                   x:activityIndicatorView.center.x, y:
                   activityIndicatorView.center.y + actualSize.height)
               label.textAlignment = .center
               label.text = message
               label.font = UIFont.appFont_Poppins_Regular_WithSize(16.0)
               label.textColor = activityIndicatorView.color
               activityContainer.addSubview(label)
           }
       }
       UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
       if isFromOnView == true {
           UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(activityContainer)
       }
       else {
           UIApplication.shared.keyWindow?.addSubview(activityContainer)
       }
}

/**
 Stop animation and remove from view hierarchy.
 */
private func stopActivityAnimating(isFromOnView:Bool) {
    UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
    if isFromOnView == true {
        for item in (UIApplication.shared.keyWindow?.rootViewController?.view.subviews)!
            where item.restorationIdentifier == activityRestorationIdentifier {
                item.removeFromSuperview()
        }
    }
    else {
        if UIApplication.shared.keyWindow != nil{
            for item in (UIApplication.shared.keyWindow?.subviews)!
                where item.restorationIdentifier == activityRestorationIdentifier {
                    item.removeFromSuperview()
            }
        }
    }
}


