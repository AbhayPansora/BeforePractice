//
//  AIExtensions.swift
//  Swift3CodeStructure
//
//  Created by Abhay Pansora on 25/11/2016.
//  Copyright © 2016 Abhay Pansora. All rights reserved.
//

import QuartzCore
import Foundation
import UIKit
import AudioToolbox
import AVFoundation
import CommonCrypto
import Contacts
import MapKit

extension CGFloat
{
    func proportionalFontSize() -> CGFloat {
        var sizeToCheckAgainst = self
        if(IS_IPAD_DEVICE())    {
            sizeToCheckAgainst += 12
        }
        else {
            if(IS_IPHONE_6P_OR_6SP()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_6_OR_6S()) {
                sizeToCheckAgainst -= 0
            }
            else if(IS_IPHONE_5_OR_5S()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_4_OR_4S()) {
                sizeToCheckAgainst -= 2
            }
        }
        return sizeToCheckAgainst
    }
}

extension UIDevice {
    
    static func vibrate() {
        //        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // vibrate
        //        AudioServicesPlayAlertSound(SystemSoundID(1157)) //Sound with vibrate
        AudioServicesPlaySystemSound(SystemSoundID(1157)) // sound like pickerview data change
    }
    
    static func SendMessageSound() {
        AudioServicesPlaySystemSound(SystemSoundID(1004))
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}

extension String {
    func Size_Of_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
        return size;
    }
    func heightWithWidthAndFont(_ width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func currencyFormatter()-> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "kk_KZ")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        //        formatter.minimumFractionDigits = 1
        formatter.groupingSeparator = ","
        let amt = Float(self)
        return formatter.string(from: NSNumber(integerLiteral: Int(amt ?? 0.0))) ?? ""
    }
    
    func isValidEmailBoth(str:String) -> Bool    {
        let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    func isValidEmail(_ stringToCheckForEmail:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
    }
    
    func isValidEmail_NEW(_ stringToCheckForEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: stringToCheckForEmail)
    }
    
    func trimString(str : String) -> String{
        let getstr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return getstr
    }
    
    var length: Int {
        return self.count
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(from: Int) -> String {
        return self[min(from, length) ..< length]
    }
    
    func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self [start ..< end])
    }
    func fromUTCToLocalTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//2022-12-08T12:28:16.427Z
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }
        dateFormatter.dateFormat = "MMM dd, yyyy" //Aug 05, 2022
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    func fromUTCtoShortDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }
        guard let date = dateFormatter.date(from: formattedString) else {
            return self.getDate() ?? Date()
        }
        dateFormatter.dateFormat = "MMM dd, yyyy" //Aug 05, 2022
        dateFormatter.timeZone = TimeZone.current
        return date
    }
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
    
    func setDateFormatToSend(strDate : String) -> String
    {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "MM-dd-yy"
        let getDate = dateFormatter1.date(from: strDate)
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        return dateFormatter1.string(from: getDate!)
    }
    
    func formatedDateWithDefaultDate(withFormat format: String) -> Date? {
        let formatter: DateFormatter = .init()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.defaultDate = Date()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func formatedDate(withFormat format: String) -> Date? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
    
    var htmlToConvertAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

extension NSLayoutConstraint {
    
    func setMultiplier(_ multiplier:CGFloat) -> NSLayoutConstraint {
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        newConstraint.isActive = true
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension UILabel {
    
    func setLineHeight(_ lineHeight: CGFloat) {
        self.setLineHeight(lineHeight, withAlignment: .center)
    }
    
    func setLineHeight(_ lineHeight: CGFloat, withAlignment alignment:NSTextAlignment) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            style.alignment = alignment
            
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
            
        }
    }
    
    func setBetweenSpace() {
        setBetweenSpace(space: 1.5)
    }
    func setBetweenSpace(space:CGFloat) {
        let text = self.text
        
        if let text = text {
            
            let attributeString = NSMutableAttributedString(string: text)
            
            attributeString.addAttribute(NSAttributedString.Key.kern, value: GET_PROPORTIONAL_WIDTH(space), range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
    
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}

extension UISearchBar {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let textfield = self.value(forKey: "searchField") as? UITextField{
            textfield.textColor = APP_WHITE_COLOR
            textfield.backgroundColor = APP_WHITE_COLOR
        }
        self.tintColor = UIColor.black
    }
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

extension UITextField{
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocapitalizationType = UITextAutocapitalizationType.none;
        self.autocorrectionType = UITextAutocorrectionType.no;
        
        let view = UIView(frame: CGRect(x: 10, y: 0, width: IS_IPAD_DEVICE() ? 30 : 15, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always;
        self.leftView = view
        self.tintColor = APP_WHITE_COLOR
        self.textColor = APP_WHITE_COLOR
        self.backgroundColor = APP_TEXTFIELD_BG_COLOR
        self.font = IS_IPAD_DEVICE() ? UIFont(name: FONT_REGULAR, size: 22) : UIFont(name: FONT_REGULAR, size: 14)
        self.applyCornerRadius(APP_CORNER_RADIOUS_5)
        
        if self.keyboardType == UIKeyboardType.numberPad || self.keyboardType == UIKeyboardType.phonePad || self.keyboardType == UIKeyboardType.decimalPad {
            let toolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 40 / 100))
            toolbar.sizeToFit()
            let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(btnBarDoneAction))
            toolbar.items = [barBtnDone]
            self.inputAccessoryView = toolbar
        }
    }
    
    func showDoneButtonOnKeyboard() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        var toolBarItems = [UIBarButtonItem]()
        toolBarItems.append(flexSpace)
        toolBarItems.append(doneButton)
        toolbar.items = toolBarItems
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
    
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = APP_WHITE_COLOR.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func applyCornerRadious()
    {
        self.layer.cornerRadius = self.frame.size.width/16
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
    func setPlachholderText(str : String){
        self.attributedPlaceholder = NSAttributedString(string: str,
                                                        attributes: [NSAttributedString.Key.foregroundColor: APP_GRAY_COLOR , NSAttributedString.Key.font : UIFont(name: FONT_REGULAR, size: 16) as Any])
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension UITextView
{
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.autocapitalizationType = UITextAutocapitalizationType.none;
        self.autocorrectionType = UITextAutocorrectionType.no;
        //    self.textContainerInset = UIEdgeInsets(top: 10,left: 10,bottom: 0 ,right: 0);
        if self.tag == 0 {
            self.textColor = APP_WHITE_COLOR
            self.font = IS_IPAD_DEVICE() ? UIFont(name: FONT_REGULAR, size: 23.0) : UIFont(name: FONT_REGULAR, size: 14.0)
        }else{
            self.textColor = APP_WHITE_COLOR
            self.font = IS_IPAD_DEVICE() ? UIFont(name: FONT_REGULAR, size: 23.0) : UIFont(name: FONT_REGULAR, size: 14.0)
        }
        if self.tag != 111{
            if self.keyboardType == UIKeyboardType.default {
                let toolbar = UIToolbar.init()
                toolbar.sizeToFit()
                let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(btnBarDoneAction))
                toolbar.items = [barBtnDone]
                self.inputAccessoryView = toolbar
            }
        }
        self.applyCornerRadius(APP_CORNER_RADIOUS_5)
        self.backgroundColor = UIColor.clear
    }
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
}

extension UIFont {
    
    // Poppins Regular
    class func appFont_Poppins_Regular_WithSize(_ fontSize : CGFloat) -> UIFont {
        return UIFont(name: FONT_REGULAR, size: fontSize.proportionalFontSize())!
    }
    
    // Poppins-Medium
    class func appFont_Poppins_medium_WithSize(_ fontSize : CGFloat) -> UIFont {
        return UIFont(name: FONT_MEDIUM, size: fontSize.proportionalFontSize())!
    }
    
    // Poppins-Bold
    class func appFont_Poppins_Bold_WithSize(_ fontSize : CGFloat) -> UIFont {
        return UIFont(name: FONT_BOLD, size: fontSize.proportionalFontSize())!
    }
    
    // Poppins-SemiBold
    class func appFont_Poppins_SemiBold_WithSize(_ fontSize : CGFloat) -> UIFont {
        return UIFont(name: FONT_NEXA_BOLD, size: fontSize.proportionalFontSize())!
    }
}

//MARK: - MULTIPLIER CONSTRAINT

extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        newConstraint.isActive = true
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIView{
    // HEIGHT / WIDTH
    
    var width:CGFloat {
        return self.frame.size.width
    }
    var height:CGFloat {
        return self.frame.size.height
    }
    var xPos:CGFloat {
        return self.frame.origin.x
    }
    var yPos:CGFloat {
        return self.frame.origin.y
    }
    
    // BORDER
    func applyTheameBlueBorderDefault() {
        self.applyBorder(APP_GRAY_COLOR, width: 1.0)
    }
    func applyBorderDefault() {
        self.applyBorder(UIColor.red, width: 1.0)
    }
    func applyBorderDefault1() {
        self.applyBorder(UIColor.green, width: 1.0)
    }
    func applyBorderDefault2() {
        self.applyBorder(UIColor.blue, width: 1.0)
    }
    func applyBorderDefault3() {
        self.applyBorder(UIColor.black, width: 1.0)
    }
    func applyBorder(_ color:UIColor, width:CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func applyCircle() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) * 0.5
        self.layer.masksToBounds = true
    }
    func applyCircleWithRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func applyGradientBoarder(){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [APP_BOARDER_START_COLOR,APP_BOARDER_CENTER_COLOR,APP_BOARDER_END_COLOR].map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 1, dy: 1), cornerRadius: APP_CORNER_RADIOUS_10).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    func applyGradientBoarderWithColor(arr : [UIColor]){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = arr.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 1, dy: 1), cornerRadius: APP_CORNER_RADIOUS_10).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    // CORNER RADIUS
    func applyCornerRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func applyCornerRadiusDefault() {
        self.applyCornerRadius(5.0)
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func applyButtonShadow() -> Void{
        self.layer.shadowColor = APP_GRAY_COLOR.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
    func setSpecificCornerRadius(size: CGSize, corners: UIRectCorner){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath
            rectShape.borderColor = APP_THEAM_COLOR.cgColor
            rectShape.borderWidth = 0.0
            self.layer.mask = rectShape
        }
    }
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
          onClick()
        }
    }
    
    // SHADOW
    func setViewShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = false
    }
    
    func applyShadowDefault(){
        self.applyShadowWithColor(UIColor.black, opacity: 0.5, radius: 1)
    }
    
    func applyShadowWithColor(_ color:UIColor)    {
        self.applyShadowWithColor(color, opacity: 0.5, radius: 3)
    }
    
    func applyShadowWithColor(_ color:UIColor, opacity:Float, radius: CGFloat)    {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 5, height: 0)
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
    }
    
    func applyShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
    }
    
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        layer.cornerRadius = CGFloat(frame.width / 20)
        
        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
        
        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func applyGradient() -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [APP_START_COLOR,APP_CENTER_COLOR,APP_END_COLOR].map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.cornerRadius = APP_CORNER_RADIOUS_10
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
class ClickListener: UITapGestureRecognizer {
  var onClick : (() -> Void)? = nil
}

extension NSDictionary{
    
    func object_forKeyWithValidationForClass_Int(_ aKey: String) -> Int {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return Int()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return Int()
            }
        } else {
            // KEY NOT FOUND
            return Int()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return Int()
        }
        else {
            
            if aValue is Int {
                return self.object(forKey: aKey) as! Int
            }
            else{
                return Int()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_CGFloat(_ aKey: String) -> CGFloat
    {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return CGFloat()
        }
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return CGFloat()
            }
        } else {
            // KEY NOT FOUND
            return CGFloat()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return CGFloat()
        }
        else {
            if aValue is CGFloat {
                return self.object(forKey: aKey) as! CGFloat
            }
            else{
                return CGFloat()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_String(_ aKey: String) -> String {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return String()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return String()
            }
        } else {
            // KEY NOT FOUND
            return String()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return String()
        }
        else {
            
            if aValue is String {
                return self.object(forKey: aKey) as! String
            }
            else{
                return String()
            }
            
            //            return self.objectForKey(aKey) as! String
        }
    }
    
    func object_forKeyWithValidationForClass_Bool(_ aKey: String) -> Bool {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return Bool()
        }
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return Bool()
            }
        } else {
            // KEY NOT FOUND
            return Bool()
        }
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return Bool()
        }
        else {
            
            if aValue is Bool {
                return self.object(forKey: aKey) as! Bool
            }
            else{
                return Bool()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSArray(_ aKey: String) -> NSArray {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSArray()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSArray()
            }
        } else {
            // KEY NOT FOUND
            return NSArray()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSArray()
        }
        else {
            if aValue is NSArray {
                return self.object(forKey: aKey) as! NSArray
            }
            else{
                return NSArray()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSMutableArray(_ aKey: String) -> NSMutableArray {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSMutableArray()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSMutableArray()
            }
        } else {
            // KEY NOT FOUND
            return NSMutableArray()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSMutableArray()
        }
        else {
            
            if aValue is NSMutableArray {
                return self.object(forKey: aKey) as! NSMutableArray
            }
            else{
                return NSMutableArray()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSDictionary(_ aKey: String) -> NSDictionary {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSDictionary()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSDictionary()
            }
        } else {
            // KEY NOT FOUND
            return NSDictionary()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSDictionary()
        }
        else {
            
            if aValue is NSDictionary {
                return self.object(forKey: aKey) as! NSDictionary
            }
            else{
                return NSDictionary()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSMutableDictionary(_ aKey: String) -> NSMutableDictionary {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSMutableDictionary()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSMutableDictionary()
            }
        } else {
            // KEY NOT FOUND
            return NSMutableDictionary()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSMutableDictionary()
        }
        else {
            
            if aValue is NSMutableDictionary {
                return self.object(forKey: aKey) as! NSMutableDictionary
            }
            else{
                return NSMutableDictionary()
            }
        }
    }
    
    
    func dictionaryByReplacingNullsWithBlanks() -> NSMutableDictionary {
        let dictReplaced : NSMutableDictionary = self.mutableCopy() as! NSMutableDictionary
        
        
        let null : AnyObject = NSNull()
        let blank : NSString = ""
        
        for key : Any in self.allKeys {
            let strKey : NSString  = key as! NSString
            let object : AnyObject = self.object(forKey: strKey)! as AnyObject
            if object.isEqual(null) {
                dictReplaced.setObject(blank, forKey: strKey)
                
            }else if object.isKind(of : NSDictionary.self) {
                dictReplaced.setObject((object as! NSDictionary).dictionaryByReplacingNullsWithBlanks(), forKey: strKey)
            }else if object.isKind(of : NSArray.self) {
                dictReplaced.setObject((object as! NSArray).arrayByReplacingNullsWithBlanks(), forKey: strKey)
            }
        }
        return dictReplaced
    }
    
    
    func dictionaryByAppendingKey(_ value : String) -> NSMutableDictionary {
        let dictReplaced : NSMutableDictionary = self.mutableCopy() as! NSMutableDictionary
        dictReplaced.setObject(value, forKey: "reviewType" as NSCopying)
        return dictReplaced
    }
    
    func object_forKeyWithValidationForClass_ArrayOfNSDictionary(_ aKey: String) -> [NSDictionary] {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return [NSDictionary()]
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return [NSDictionary()]
            }
        } else {
            // KEY NOT FOUND
            return [NSDictionary()]
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return [NSDictionary()]
        }
        else {
            
            if aValue is [NSDictionary] {
                return self.object(forKey: aKey) as! [NSDictionary]
            }
            else{
                return [NSDictionary()]
            }
        }
    }
    
}

extension NSArray{
    
    func arrayByReplacingNullsWithBlanks () -> NSMutableArray {
        let arrReplaced : NSMutableArray = self.mutableCopy() as! NSMutableArray
        let null : AnyObject = NSNull()
        let blank : NSString = ""
        
        for idx in 0..<arrReplaced.count {
            let object : AnyObject = arrReplaced.object(at: idx) as AnyObject
            if object.isEqual(null) {
                arrReplaced.setValue(blank, forKey: object.key!!)
                
            }else if object.isKind(of: NSDictionary.self) {
                arrReplaced.replaceObject(at: idx, with: (object as! NSDictionary).dictionaryByReplacingNullsWithBlanks())
            }else if object.isKind(of: NSArray.self) {
                arrReplaced.replaceObject(at: idx, with: (object as! NSArray).arrayByReplacingNullsWithBlanks())
            }
        }
        
        return arrReplaced
    }
    
    func arrayByAppendingKey(_ value : String) -> NSMutableArray {
        let arrReplaced : NSMutableArray = self.mutableCopy() as! NSMutableArray
        
        for idx in 0..<arrReplaced.count {
            let object : AnyObject = arrReplaced.object(at: idx) as AnyObject
            if object.isKind(of :NSDictionary.self) {
                
                arrReplaced.replaceObject(at: idx, with: (object as! NSDictionary).dictionaryByAppendingKey(value))
                
            }
        }
        return arrReplaced
    }
}

class ImageLoader: UIImageView {
    public func loadImageWith(from urlString: String, completion: @escaping (Bool, UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, UIImage())
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data) {
                    completion(true, imageToCache)
                } else {
                    completion(false, UIImage())
                }
            }
        }.resume()
    }
}

extension UIImageView {
    func imageFromServerURL(_ URLString: String) {
        self.image = nil
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIButton {
    
    
    
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font as Any])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
    func alignTextBelow1(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font as Any])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.showsTouchWhenHighlighted = false
    }
    
    func underlineButton(text: String, color:UIColor) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, text.count))
        titleString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
    
    func setBetweenSpace() {
        setBetweenSpace(space: 1.5)
    }
    func setBetweenSpace(space:CGFloat) {
        let text = self.titleLabel?.text
        
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.kern, value: GET_PROPORTIONAL_WIDTH(space), range: NSMakeRange(0, text.count))
            self.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
    //    func setHyperLink() {
    //        let text: String = self.currentTitle!;
    //        let dictAttribute: [String: AnyObject] = [NSAttributedString.Key.underlineStyle.rawValue:NSUnderlineStyle.single.rawValue as AnyObject,
    //                                                  NSAttributedString.Key.foregroundColor.rawValue:(self.titleLabel?.textColor)!]
    //        //self.titleLabel?.attributedText = NSAttributedString(string: text, attributes: dictAttribute)
    //        self.titleLabel?.attributedText = NSAttributedString(string: text, attributes: dictAttribute as? [NSAttributedString.Key : Any])
    //    }
    
    func setMultiLineText() {
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 6.0
        self.layer.cornerRadius = self.height/2
        self.clipsToBounds = false
    }
    
    func appBtn(color: UIColor){
        self.backgroundColor = color
        self.showsTouchWhenHighlighted = false
        self.titleLabel?.font = UIFont(name: FONT_MEDIUM, size: 16)
        self.setTitleColor(APP_WHITE_COLOR, for: .normal)
        self.layer.cornerRadius = 15
    }
    
}


extension UIDevice
{
    // Device Family : iPhone,iPad, ...
    public var deviceFamily: String {
        return UIDevice.current.model
    }
    //Device iOS Version : 8.1, 8.1.3, ...
    public var deviceIOSVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public var deviceOrientationString: String {
        var orientation : String
        switch UIDevice.current.orientation{
        case .portrait:
            orientation="Portrait"
        case .portraitUpsideDown:
            orientation="Portrait Upside Down"
        case .landscapeLeft:
            orientation="Landscape Left"
        case .landscapeRight:
            orientation="Landscape Right"
        case .faceUp:
            orientation="Face Up"
        case .faceDown:
            orientation="Face Down"
        default:
            orientation="Unknown"
        }
        return orientation
    }
}

extension Date
{
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func adding(year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    static func dates(from fromDate: Date, to toDate: Date, format inFormate : String) -> [String] {
        var dates: [String] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date.formatedString(withFormat: inFormate)!)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func adding(month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self)!
    }
    func adding(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
    
    
    func formatedString(withFormat format: String = "yyyy/MM/dd") -> String? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    func formated(withFormat format: String = "yyyy/MM/dd") -> Date? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return formatter.date(from: dateString)
    }
    
    func daysSince(_ anotherDate: Date) -> Int? {
        if let fromDate = dateFromComponents(self), let toDate = dateFromComponents(anotherDate) {
            let components = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
            return components.day
        }
        return nil
    }
    
    private func dateFromComponents(_ date: Date) -> Date? {
        let calender   = Calendar.current
        let components = calender.dateComponents([.year, .month, .day], from: date)
        return calender.date(from: components)
    }
}

extension NSDate
{
    class func getCurrentYear() -> Int
    {
        let currDate = NSDate()
        let components = NSCalendar.current.component(Calendar.Component.year, from: currDate as Date)
        return components
    }
    
    
    class func getDayReturn(_ getDate : Date) -> Int
    {
        //  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        let date = getDate
        let cal = Calendar.current
        let day : Int = cal.component(.day, from: date as Date)
        return day
    }
    
    
    // APP SPECIFIC FORMATS
    func app_stringFromDate() -> String{
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let strdt = dateFormatter.string(from: self as Date)
        if let dtDate = dateFormatter.date(from: strdt){
            return dateFormatter.string(from: dtDate)
        }
        return "--"
    }
    
    func app_dateFormatString() -> String{
        return "\(self.dayOneDigit) \(self.monthNameShort.uppercased()), \(self.dayNameShort.uppercased())"
    }
    
    func app_dateFormatStringShort() -> String{
        return "\(self.dayOneDigit) \(self.monthNameShort.uppercased())"
    }
    
    func app_dateFormatStringForReview() -> String{
        return "\(self.dayOneDigit) \(self.monthNameShort.capitalized), \(self.yearFourDigit)"
    }
    
    func app_dateFormatStringForCreditCardDate() -> String{
        return "\(self.monthNameShort.capitalized), \(self.yearFourDigit)"
    }
    
    func app_dateFormatStringForPlaceOrder() -> String{
        return "\(self.yearFourDigit)-\(self.monthTwoDigit)-\(self.dayTwoDigit)"
    }
    
    func getUTCFormateDate(localDate: NSDate) -> String {
        
        let dateFormatter: DateFormatter = DateFormatter()
        let timeZone: NSTimeZone = NSTimeZone(name: "UTC")!
        dateFormatter.timeZone = timeZone as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateString: String = dateFormatter.string(from: localDate as Date)
        return dateString
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending || self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isGreaterThanEqualDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending  {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    class func currentDate() -> NSDate
    {
        let date1 = NSDate()
        let formater : DateFormatter = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let str = formater.string(from: date1 as Date)
        
        let formater1 : DateFormatter = DateFormatter()
        formater1.dateFormat = "yyyy-MM-dd"
        return formater1.date(from : str)! as NSDate
    }
    
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        //Return Result
        return isEqualTo
    }
    
    func isEqualToDateWithoutTime(dateToCompareWith:NSDate) -> Bool {
        if(self.dayTwoDigit_Int == dateToCompareWith.dayTwoDigit_Int &&
           self.monthTwoDigit_Int == dateToCompareWith.monthTwoDigit_Int &&
           self.yearFourDigit_Int == dateToCompareWith.yearFourDigit_Int){
            return true
        }else{
            return false
        }
    }
    
    // TIME
    var timeWithAMPM: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self as Date)
    }
    
    var timeWithFull : String
    {
        let dateFormatter = DateFormatter()
        //        NSTimeZone *gmtZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        //        [dateFormatter setTimeZone:gmtZone];
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self as Date)
    }
    
    // YEAR
    var yearFourDigit_Int: Int {
        return Int(self.yearFourDigit)!
    }
    
    var yearOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y"
        return dateFormatter.string(from: self as Date)
    }
    var yearTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy"
        return dateFormatter.string(from: self as Date)
    }
    var yearFourDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self as Date)
    }
    
    // MONTH
    var monthOneDigit_Int: Int {
        return Int(self.monthOneDigit)!
    }
    var monthTwoDigit_Int: Int {
        return Int(self.monthTwoDigit)!
    }
    
    
    var monthOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return dateFormatter.string(from: self as Date)
    }
    var monthTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self as Date)
    }
    var monthNameShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self as Date)
    }
    var monthNameFull: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self as Date)
    }
    var monthNameFirstLetter: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMMM"
        return dateFormatter.string(from: self as Date)
    }
    
    // DAY
    
    var dayOneDigit_Int: Int {
        return Int(self.dayOneDigit)!
    }
    var dayTwoDigit_Int: Int {
        return Int(self.dayTwoDigit)!
    }
    
    var dayOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self as Date)
    }
    var dayTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self as Date)
    }
    var dayNameShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self as Date)
    }
    var dayNameFull: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
    var dayNameFirstLetter: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEE"
        return dateFormatter.string(from: self as Date)
    }
    
    
    
    
    // AM PM
    var AM_PM: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: self as Date)
    }
    
    // HOUR
    
    var hourOneDigit_Int: Int {
        return Int(self.hourOneDigit)!
    }
    var hourTwoDigit_Int: Int {
        return Int(self.hourTwoDigit)!
    }
    var hourOneDigit24Hours_Int: Int {
        return Int(self.hourOneDigit24Hours)!
    }
    var hourTwoDigit24Hours_Int: Int {
        return Int(self.hourTwoDigit24Hours)!
    }
    var hourOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h"
        return dateFormatter.string(from: self as Date)
    }
    var hourTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.string(from: self as Date)
    }
    var hourOneDigit24Hours: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        return dateFormatter.string(from: self as Date)
    }
    var hourTwoDigit24Hours: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self as Date)
    }
    
    // MINUTE
    
    var minuteOneDigit_Int: Int {
        return Int(self.minuteOneDigit)!
    }
    var minuteTwoDigit_Int: Int {
        return Int(self.minuteTwoDigit)!
    }
    
    var minuteOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "m"
        return dateFormatter.string(from: self as Date)
    }
    var minuteTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.string(from: self as Date)
    }
    
    
    // SECOND
    
    var secondOneDigit_Int: Int {
        return Int(self.secondOneDigit)!
    }
    var secondTwoDigit_Int: Int {
        return Int(self.secondTwoDigit)!
    }
    
    var secondOneDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "s"
        return dateFormatter.string(from: self as Date)
    }
    var secondTwoDigit: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        return dateFormatter.string(from: self as Date)
    }
}

extension UIImage {
    
    //Load Gif Image - begin
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Source for the image does not exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("This image named \"\(url)\" does not exist")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
                    print("This image named \"\(name)\" does not exist")
                    return nil
                }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        
        return gif(data: dataAsset.data)
    }
    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!
            
            if rest == 0 {
                return rhs! // Found it
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for index in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
    //Load Gif Image - end
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 0, height: size.height))//(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage
    {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    static func gradientImage(with bounds: CGRect,
                                colors: [CGColor],
                       locations: [NSNumber]?) -> UIImage? {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                           y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                         y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

}

public extension UIWindow
{
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController?
    {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

extension UIViewController {
    func backViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reversed() {
                if(stack[i] == self) {
                    return stack[i-1]
                }
            }
        }
        return nil
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func removeChild() {
        self.children.forEach {
          $0.willMove(toParent: nil)
          $0.view.removeFromSuperview()
          $0.removeFromParent()
        }
    }
    func formatPoints(from: Int) -> String {
        let number = Double(from)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        } else if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else if billion >= 1.0 {
            return ("\(round(billion*10/10))B")
        } else {
            return "\(Int(number))"}
    }
    func setEmptyMessage(_ message: String) {
        for subView in self.view.subviews{
            if subView.tag == 5001{
                print("subView removed")
                subView.removeFromSuperview()
           }
        }
        let messageLabel = UILabel(frame: CGRect(x: 20, y: self.view.bounds.size.height/2, width: self.view.bounds.size.width-20, height: self.view.bounds.size.height))
        messageLabel.tag = 5001
        messageLabel.text = message
        messageLabel.textColor = APP_WHITE_COLOR
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.font = UIFont(name: FONT_NEXA_BOLD, size: 14.0)
        messageLabel.sizeToFit()
        self.view.addSubview(messageLabel)
    }
}

extension UILabel {
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength()
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font as Any])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    func vissibleTextLength() -> Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
    
    func retrieveTextHeight () -> CGFloat {
        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font:self.font])
        
        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(rect.size.height)
    }
}

extension NSMutableAttributedString{
    @discardableResult func bold(_ text: String, fontName: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString{
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: size)!]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        boldString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, text.count))
        append(boldString)
        return self
    }
    @discardableResult func normal(_ text : String) -> NSMutableAttributedString{
        let normal = NSAttributedString(string: text)
        append(normal)
        return self
    }
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
struct AES {
    
    // MARK: - Value
    private let key: Data
    private let iv: Data
    
    // MARK: - Initialzier
    init?(key: String, iv: String) {
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256, let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }
        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }
        self.key = keyData
        self.iv  = ivData
    }
    
    // MARK: - Function
    func encrypt(string: String) -> Data? {
        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
    }
    
    func decrypt(data: Data?) -> String? {
        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }
    
    func encryptString(string: String) -> String? {
        if string == nil || string.isEmpty {
            return ""
        }
        let data: Data = crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))!
        return data.base64EncodedString()
    }
    
    func decryptString(string: String) -> String? {
        if string == nil || string.isEmpty {
            return ""
        }
        let data = NSData(base64Encoded: string, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        if data != nil {
            guard let decryptedData = crypt(data: data! as Data, option: CCOperation(kCCDecrypt)) else { return nil }
            return String(bytes: decryptedData, encoding: .utf8)
        }
        return ""
    }
    
    
    func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }
        
        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)
        
        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)
        
        var bytesLength = Int(0)
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }
        
        guard UInt32(status) == UInt32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }
        
        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}


extension UIDevice {
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}

extension String {
    
    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        
        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))
            
            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        
        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }
        
        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 50, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}
extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
    func fetchStateAndCountry(completion: @escaping (_ city: String?,_ state: String?, _ country:  String?, _ countryCode:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality,$0?.first?.administrativeArea, $0?.first?.country,$0?.first?.isoCountryCode, $1) }
    }
}
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: FONT_NEXA_BOLD, size: 14.0)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .large
            } else {
                // Fallback on earlier versions
                activityIndicatorView.style = .whiteLarge
            }
            
            activityIndicatorView.color = APP_BLUE_COLOR
            activityIndicatorView.hidesWhenStopped = true
            
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }
        else {
            return activityIndicatorView
        }
    }
    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }
    func stopLoading() {
        if self.tableFooterView != nil {
            self.indicatorView().stopAnimating()
            self.tableFooterView = nil
        }
        else {
            self.tableFooterView = nil
        }
    }
}
extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: FONT_NEXA_BOLD, size: 14.0)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

extension UIDatePicker {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.locale = Locale(identifier: "en_GB")
//        self.minuteInterval = 15
    }

    func setDatePickerStyle() {
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
    }
}
