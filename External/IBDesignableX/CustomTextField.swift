//
//  CustomTextField.swift
//  Liber
//
//  Created by Abhay on 22/09/18.
//  Copyright © 2018 Abhay. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextField: UITextField {

    @IBInspectable
    var leftPaddingView: Int {
        get{
            return self.leftPaddingView
        }
        set {
            let paddingView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: newValue, height: 10))
            leftViewMode = .always
            leftView = paddingView
        }
    }
    
    @IBInspectable
    var rightPaddingView: Int {
        get{
            return self.rightPaddingView
        }
        set {
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 10))
            rightViewMode = .always
            rightView = paddingView
        }
    }

    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
     
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "" , attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage {
                leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x:0, y: 0, width: 55, height: frame.height))
                imageView.center = view.center
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }
        }
    }
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            if let image = rightImage {
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: frame.height))
                imageView.center = view.center
                view.addSubview(imageView)
                rightView = view
            } else {
                rightViewMode = .never
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var maximumCharacters: Int = 80 {
            didSet {
                limitCharacters()
            }
        }
    override func awakeFromNib() {
            super.awakeFromNib()
            limitCharacters()
            addTarget(self, action: #selector(CustomTextField.limitCharacters), for: .editingChanged)
        }
    @objc func limitCharacters() {
            guard text != nil else {
                return
            }
            if (text?.count)! > maximumCharacters {
                if let range = text?.index(before: (text?.endIndex)!) {
                    text = text?.substring(to: range)
                }
            }
        }
}
