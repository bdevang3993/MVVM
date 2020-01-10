//
//  UserViewModel.swift
//  MVVMLoginDemo
//
//  Created by devang bhavsar on 28/12/19.
//  Copyright © 2019 devang bhavsar. All rights reserved.
//

import Foundation
class UserViewModel: NSObject {
    var userModel = UserModel(email: "", password: "")
    var signUpModel = SignUpModel(name: "", email: "", password: "", cnfPassword: "")
    //MARK:- Property observer
    var email =  "" {
        didSet {
            print("email Id = \(email)")
            userModel.email = email
        }
    }
    var password = "" {
        didSet {
            userModel.password = password
            print("Pasword = \(password)")
        }
    }
    func validationOfData() throws -> Bool {
        let isvalidate = isValidEmail(emailStr: userModel.email)
        let validateCredential:Bool = matchCredential()
        if userModel.email.isEmpty {
              throw LoginValidation.emailEmpty
          }
          else if !isvalidate {
                throw LoginValidation.emailValidation
          }
        else if userModel.password.isEmpty {
              throw LoginValidation.passwordEmpty
          }
          else if !validateCredential {
            throw LoginValidation.emailIdnotmatch
        }
        return true
      }
    //MARK:-  Match Model Data
    func matchCredential() -> Bool {
        if signUpModel.email != userModel.email {
            return false
        }
        else if signUpModel.password != userModel.password {
            return false
        }
        else {
             return true
        }
       
    }
}
