//
//  AllCustomMethods.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 03/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit
//MARK:- TypeDefine Declaration
typealias TaSignUpModel = (SignUpModel) -> Void
typealias TaAPICallBack = (String) -> Void
typealias TransferAPICallBack = (String) -> Void
func modifyData()  {
}
//MARK:- Custom TextField Method
func setCustomTextField(self:UITextField,placeHolder:String) -> UITextField {
    self.font = UIFont(name: CustomFontName().textfieldFontName, size: CustomFontSize().textfieldFontSize)
    self.textColor = UIColor.black
    //self.borderStyle = borderStyle
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 10.0
    self.setLeftPaddingPoints(10.0)
    self.setRightPaddingPoints(10.0)
    self.placeholder  = placeHolder
    return self
}
//MARK:- EmailValidation
func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}
//MARK:- Remove Space before and after line
func removeWhiteSpace(strData:String) -> String {
    var trimmed:String = strData.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed
}
