//
//  SignUpViewModel.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 04/01/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import Foundation
class SignUpViewModel: NSObject {
   var signUpModel = SignUpModel(name: "", email: "", password: "", cnfPassword: "")
   
    func validationOfData() throws -> Bool {
        let nameTrimSpace:String = removeWhiteSpace(strData: signUpModel.name)
        signUpModel.name = nameTrimSpace
        let emailTrimSpace:String = removeWhiteSpace(strData: signUpModel.email)
        signUpModel.email = emailTrimSpace
        let passwordTrimSpace:String = removeWhiteSpace(strData: signUpModel.password)
        signUpModel.password = passwordTrimSpace
        let cnfPasswordTrimSpace:String = removeWhiteSpace(strData: signUpModel.cnfPassword)
        signUpModel.cnfPassword = cnfPasswordTrimSpace
        
        let isvalidate = isValidEmail(emailStr: signUpModel.email)
        
        if signUpModel.name == "" {
            throw LoginValidation.nameEmpty
        }
          else if signUpModel.email == "" {
              throw LoginValidation.emailEmpty
          }
          else if !isvalidate {
                throw LoginValidation.emailValidation
          }
          else if signUpModel.password == "" {
              throw LoginValidation.passwordEmpty
          }
          else if signUpModel.cnfPassword == "" {
            throw LoginValidation.confirmPassword
        }
          else if signUpModel.password != signUpModel.cnfPassword {
            throw LoginValidation.passwordNotMatch
        }
        return true
         print("Validation Success")
      }
    
}
