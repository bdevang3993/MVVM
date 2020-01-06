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
   
    func validationOfData() throws -> Bool {
        let isvalidate = isValidEmail(emailStr: userModel.email)
        let validateCredential:Bool = matchCredential()
          if userModel.email == "" {
              throw LoginValidation.emailEmpty
          }
          else if !isvalidate {
                throw LoginValidation.emailValidation
          }
          else if userModel.password == "" {
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
