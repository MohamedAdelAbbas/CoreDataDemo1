//
//  CustomTextField.swift
//  StormCenter
//
//  Created by Mohamed Adel on 5/25/20.
//  Copyright © 2020 Mohamed Adel. All rights reserved.
//

import UIKit
protocol DesignableTextFieldDelegate: UITextFieldDelegate {
    func textFieldIconClicked()
}
@IBDesignable
class DesignableTextField: UITextField {

    //Delegate when image/icon is tapped.
    public var myDelegate: DesignableTextFieldDelegate? {
        get { return delegate as? DesignableTextFieldDelegate }
    }

    @objc func buttonClicked() {
        self.myDelegate?.textFieldIconClicked()
    }

    //Padding images on left
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }

    //Padding images on Right
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }

    @IBInspectable var padding: CGFloat = 0 { didSet {  } }
    @IBInspectable var leadingImage: UIImage? { didSet { updateView() } }
    @IBInspectable var trailingImage: UIImage? { didSet { updateView() } }

    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { updateView() } }
    @IBInspectable var imageColor: UIColor = #colorLiteral(red: 1, green: 0.8288500309, blue: 0, alpha: 1) { didSet { updateView() } }
    @IBInspectable var trailingImageColor: UIColor = #colorLiteral(red: 1, green: 0.8288500309, blue: 0, alpha: 1) { didSet { updateView() } }

    @IBInspectable var rtl: Bool = false { didSet { updateView() } }
    @IBInspectable var heightLeft: CGFloat = 17 { didSet { updateView() } }
    @IBInspectable var heightRight: CGFloat = 17 { didSet { updateView() } }
    @IBInspectable var widthLeft: CGFloat = 25 { didSet { updateView() } }
    @IBInspectable var widthRight: CGFloat = 25 { didSet { updateView() } }
    @IBInspectable var hasHalfIcon: Bool = false { didSet { updateView() } }
    @IBInspectable var changePartOfPlaceHolder: String = "" { didSet { changePartPlaceholder() } }

    @IBInspectable var colorPartOfPlaceholder: UIColor = .lightGray { didSet { changePartPlaceholder() } }
    func updateView() {
        rightViewMode = UITextField.ViewMode.never
        rightView = nil
        leftViewMode = UITextField.ViewMode.never
        leftView = nil
        self.addPadding(.both(10))
        if let image = leadingImage {
            
            let leftImageView = UIImageView()
            leftImageView.image = image
            leftImageView.tintColor = imageColor
            let leftViewCustom = UIView()
            leftViewCustom.addSubview(leftImageView)

            leftViewCustom.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
            leftImageView.frame = CGRect(x: 5, y: hasHalfIcon ? leftViewCustom.frame.height / 2 : 0, width: widthRight, height: heightRight)
           
           
            rightViewMode = UITextField.ViewMode.always
            rightView = leftViewCustom
        
        }else {
            rightViewMode = .never
            rightView = nil
        }
        if let imageCustom = trailingImage {
            
            let leftImageView = UIImageView()
             leftImageView.image = imageCustom
             leftImageView.tintColor = trailingImageColor
             let leftViewCustom = UIView()
             leftViewCustom.addSubview(leftImageView)

             leftViewCustom.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
            leftImageView.frame = CGRect(x: 5, y:  hasHalfIcon ? leftViewCustom.frame.height / 2 : 0, width: widthLeft, height: heightLeft)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonClicked))
                       leftViewCustom.isUserInteractionEnabled = true
                       leftViewCustom.addGestureRecognizer(tapGesture)
            leftViewMode = UITextField.ViewMode.always
            leftView = leftViewCustom
            
        }else {
            leftViewMode = .never
            leftView = nil
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    func changePartPlaceholder() {
        self.halfTextColorChange(fullText: self.placeholder ?? "", changeText: changePartOfPlaceHolder)
    }
    func changeLeftImage(image:UIImage? , tintColor:UIColor)  {
        guard let image = image else {
            return
        }
        let leftImageView = UIImageView()
         leftImageView.image = image
         leftImageView.tintColor = tintColor
         let leftViewCustom = UIView()
         leftViewCustom.addSubview(leftImageView)

         leftViewCustom.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
         leftImageView.frame = CGRect(x: 5, y: hasHalfIcon ? leftViewCustom.frame.height / 2 : 0, width: widthLeft, height: heightLeft)
        leftViewMode = UITextField.ViewMode.always
        leftView = leftViewCustom
       
    }
    func changeRightImageWithoutCenter(image:UIImage? , tintColor:UIColor)  {
        guard let image = image else {
            return
        }
        let leftImageView = UIImageView()
         leftImageView.image = image
         leftImageView.tintColor = tintColor
         let leftViewCustom = UIView()
         leftViewCustom.addSubview(leftImageView)

         leftViewCustom.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
         leftImageView.frame = CGRect(x: 5, y: 0, width: widthRight, height: heightRight)
        
         rightViewMode = UITextField.ViewMode.always
         rightView = leftViewCustom
    }
    func changeRightImage(image:UIImage? , tintColor:UIColor)  {
        guard let image = image else {
            return
        }
        let leftImageView = UIImageView()
         leftImageView.image = image
         leftImageView.tintColor = tintColor
         let leftViewCustom = UIView()
         leftViewCustom.addSubview(leftImageView)

         leftViewCustom.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
         leftImageView.frame = CGRect(x: 5, y: hasHalfIcon ? leftViewCustom.frame.height / 2 : 0, width: widthRight, height: heightRight)
        
         rightViewMode = UITextField.ViewMode.always
         rightView = leftViewCustom
    }
}
extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
extension UITextField {
    func halfTextColorChange (fullText : String , changeText : String ,color:UIColor = .lightGray) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let rangeFull = (strNumber).range(of: strNumber as String)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ], range: rangeFull)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
       
        self.attributedPlaceholder = attribute

    }
}
